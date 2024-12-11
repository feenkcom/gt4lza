Class {
	#name : #GtLZAImporter,
	#superclass : #Object,
	#instVars : [
		'directory',
		'accounts',
		'metadata',
		'organizationalUnits',
		'policies',
		'transitGateways',
		'routeTables',
		'vpcs'
	],
	#category : #'Gt4LZA-Importer'
}

{ #category : #accessing }
GtLZAImporter >> directory [
	^ directory
]

{ #category : #accessing }
GtLZAImporter >> directory: anObject [
	directory := anObject
]

{ #category : #'as yet unclassified' }
GtLZAImporter >> gtAccountsFor: aView [
	<gtView>
	^ aView forward
		title: 'Accounts';
		priority: 1;
		object: [ accounts ];
		view: #gtAccountsFor:
]

{ #category : #'as yet unclassified' }
GtLZAImporter >> gtMetadataFor: aView [
	"this is a copy of Dictionary>>#gtItemsFor: that expandsAll by default and only displays the value if it’s not expandable"

	<gtView>
	^ aView columnedTree
		title: 'Meta data';
		priority: 5;
		items: [ self metadata associations sort: (#key collatedBy: #asString) ];
		children: [ :each | 
			each value isDictionary
				ifTrue: [ each value associations sort: (#key collatedBy: #asString) ]
				ifFalse: [ (each value isCollection and: [ each value isString not ])
						ifTrue: [ each value collect: [ :x | x -> '' ] ]
						ifFalse: [ #() ] ] ];
		column: 'Key' text: [ :assoc | assoc key ];
		column: 'Value'
			text: [ :assoc | 
				(assoc value isDictionary
					or: [ assoc value isCollection and: [ assoc value isString not ] ])
					ifTrue: [ '' ]
					ifFalse: [ assoc value ] ]
			weight: 3;
		contextItemLabel: 'Inspect key'
			action: [ :anElement :aTreeNode | anElement phlow spawnObject: aTreeNode value key ];
		contextItemLabel: 'Inspect association'
			action: [ :anElement :aTreeNode | anElement phlow spawnObject: aTreeNode value ];
		send: [ :assoc | assoc value ];
		expandUpTo: 1
]

{ #category : #'as yet unclassified' }
GtLZAImporter >> gtOrganizationalUnitsFor: aView [
	<gtView>
	^ aView forward
		title: 'Organizational units';
		priority: 2;
		object: [ organizationalUnits ];
		view: #gtOrganizationalUnitsFor:
]

{ #category : #'as yet unclassified' }
GtLZAImporter >> gtPoliciesFor: aView [
	<gtView>
	^ aView forward
		title: 'Policies';
		priority: 3;
		object: [ policies ];
		view: #gtPoliciesFor:
]

{ #category : #'as yet unclassified' }
GtLZAImporter >> gtRouteTablesFor: aView [
	<gtView>
	^ aView forward
		title: 'Route tables';
		priority: 3;
		object: [ routeTables ];
		view: #gtRouteTablesFor:
]

{ #category : #'as yet unclassified' }
GtLZAImporter >> gtTransitGatewaysFor: aView [
	<gtView>
	^ aView forward
		title: 'Transit gateways';
		priority: 4;
		object: [ transitGateways ];
		view: #gtTransitGatewaysFor:
]

{ #category : #'as yet unclassified' }
GtLZAImporter >> gtVpcsFor: aView [
	<gtView>
	^ aView forward
		title: 'VPCs';
		priority: 1;
		object: [ vpcs ];
		view: #gtVpcsFor:
]

{ #category : #'as yet unclassified' }
GtLZAImporter >> import [
	self assert: directory isNotNil description: 'Import directory must be set'.
	self assert: directory exists description: 'Import directory must exist'.
	
	self importOrganization.
	self importAccounts.
	self importNetwork
]

{ #category : #'as yet unclassified' }
GtLZAImporter >> importAccounts [
	| file yaml |
	file := directory / 'accounts-config.yaml'.

	file
		ifExists: [ yaml := YAMLParser parseFile: file.
			yaml object
				keysAndValuesDo: [ :aKey :aList | 
					aList
						do: [ :anAccount | 
							accounts
								add: (GtLZAAccount new
										name: (anAccount at: 'name');
										description: (anAccount at: 'description');
										email: (anAccount at: 'email');
										organizationalUnit: (organizationalUnits findNamed: (anAccount at: 'organizationalUnit'));
										type: aKey) ] ] ]
]

{ #category : #'as yet unclassified' }
GtLZAImporter >> importNetwork [
	| file yaml |
	file := directory / 'network-config.yaml'.
	yaml := (YAMLParser parseFile: file) object.

	self metadata at: 'Home region' put: (yaml at: 'homeRegion').

	self metadata at: 'Default VPC' put: (yaml at: 'defaultVpc').

	self metadata at: 'VPC Flow Logs' put: (yaml at: 'vpcFlowLogs').
	
	self importTransitGatewaysFrom: yaml.
	self importVpcsFrom: yaml
]

{ #category : #'as yet unclassified' }
GtLZAImporter >> importOrganization [
	| file object |
	file := directory / 'organization-config.yaml'.

	file
		ifExists: [ object := (YAMLParser parseFile: file) object.
			self metadata at: 'Organization enabled' put: (object at: 'enable').

			(object at: 'organizationalUnits')
				do: [ :anOu | organizationalUnits add: (GtLZAOrganizationalUnit new name: (anOu at: 'name')) ].

			{'serviceControlPolicies'.
				'taggingPolicies'.
				'backupPolicies'}
				do: [ :aPolicyKey | 
					(object at: aPolicyKey)
						do: [ :aPolicy | 
							policies
								add: (GtLZAPolicy new
										name: (aPolicy at: 'name');
										description: (aPolicy at: 'description');
										policy: self directory / (aPolicy at: 'policy');
										type: (aPolicy at: 'type' ifAbsent: [ '' ]);
										organizationalUnits: ((aPolicy at: 'deploymentTargets' at: 'organizationalUnits')
												collect: [ :aName | organizationalUnits findNamed: aName ])) ] ] ]
]

{ #category : #'as yet unclassified' }
GtLZAImporter >> importTransitGatewaysFrom: yaml [
	| transitGateway gatewayRouteTables |
	(yaml at: 'transitGateways')
		do: [ :aGateway | 
			gatewayRouteTables := GtLZARouteTablesGroup
					withAll: ((aGateway at: 'routeTables')
							collect: [ :aRouteTable | 
								GtLZARouteTable new
									name: (aRouteTable at: 'name');
									routes: ((aRouteTable at: 'routes')
											collect: [ :aRoute | 
												GtLZAGatewayRoute new
													destinationCidrBlock: (aRoute at: 'destinationCidrBlock');
													vpc: (vpcs findNamed: (aRoute at: 'attachment' at: 'vpcName'));
													account: (accounts findNamed: (aRoute at: 'attachment' at: 'account')) ]) ]).
			routeTables addAll: gatewayRouteTables.
			transitGateways
				add: (transitGateway := GtLZATransitGateway new
							name: (aGateway at: 'name');
							account: (accounts findNamed: (aGateway at: 'account'));
							region: (aGateway at: 'region');
							asn: (aGateway at: 'asn');
							dnsSupport: (aGateway at: 'dnsSupport') = 'enable';
							defaultRouteTableAssociation: (aGateway at: 'defaultRouteTableAssociation') = 'enable';
							defaultRouteTablePropagation: (aGateway at: 'defaultRouteTablePropagation') = 'enable';
							autoAcceptSharingAttachments: (aGateway at: 'autoAcceptSharingAttachments') = 'enable';
							routeTables: gatewayRouteTables).
			transitGateway
				shareTargets: (GtLZAShareTarget new
						accounts: (GtLZAAccountsGroup
								withAll: ((aGateway
										at: 'shareTargets'
										at: 'accounts'
										ifAbsent: [ {} ]) collect: [ :aName | accounts findNamed: aName ]));
						organizationalUnits: (GtLZAOrganizationalUnitsGroup
								withAll: ((aGateway
										at: 'shareTargets'
										at: 'organizationalUnits'
										ifAbsent: [ {} ])
										collect: [ :aName | (organizationalUnits findNamed: aName) addChild: transitGateway ]))) ]
]

{ #category : #'as yet unclassified' }
GtLZAImporter >> importVpcsFrom: yaml [
	| vpcRouteTables |
	(yaml at: 'vpcs')
		do: [ :aVpc | 
			vpcRouteTables := GtLZARouteTablesGroup
					withAll: ((aVpc at: 'routeTables')
							collect: [ :aRouteTable | 
								GtLZARouteTable new
									name: (aRouteTable at: 'name');
									routes: ((aRouteTable at: 'routes')
											collect: [ :aRoute | 
												GtLZARoute new
													name: (aRoute at: 'name');
													destination: (aRoute at: 'destination' ifAbsent: [ '' ]);
													type: (aRoute at: 'type');
													target: (aRoute at: 'target') ]) ]).
			routeTables addAll: vpcRouteTables.
			(vpcs findNamed: (aVpc at: 'name'))
				account: (accounts findNamed: (aVpc at: 'account'));
				region: (aVpc at: 'region');
				cidrs: (aVpc at: 'cidrs');
				internetGateway: (aVpc at: 'internetGateway' ifAbsent: [ false ]);
				enableDnsHostnames: (aVpc at: 'enableDnsHostnames' ifAbsent: [ false ]);
				enableDnsSupport: (aVpc at: 'enableDnsSupport' ifAbsent: [ false ]);
				instanceTenancy: (aVpc at: 'instanceTenancy' ifAbsent: [ false ]);
				queryLogs: (aVpc at: 'queryLogs' ifAbsent: [ {} ]);
				routeTables: vpcRouteTables;
				subnets: (aVpc at: 'subnets');
				transitGatewayAttachments: (GtLZATransitGatewayAttachmentsGroup
						withAll: ((aVpc at: 'transitGatewayAttachments')
								collect: [ :anAttachment | 
									GtLZATransitGatewayAttachment new
										name: (anAttachment at: 'name');
										transitGateway: (transitGateways findNamed: (anAttachment at: 'transitGateway' at: 'name'));
										routeTableAssociations: (GtLZARouteTablesGroup
												withAll: ((anAttachment at: 'routeTableAssociations')
														collect: [ :aName | routeTables findNamed: aName ]));
										routeTablePropagations: (GtLZARouteTablesGroup
												withAll: ((anAttachment at: 'routeTablePropagations')
														collect: [ :aName | routeTables findNamed: aName ]));
										subnets: (anAttachment at: 'subnets') ]));
				gatewayEndpoints: (aVpc at: 'gatewayEndpoints');
				interfaceEndpoints: (aVpc at: 'interfaceEndpoints' ifAbsent: [ nil ]) ]
]

{ #category : #'as yet unclassified' }
GtLZAImporter >> initialize [
	accounts := GtLZAAccountsGroup new.
	organizationalUnits := GtLZAOrganizationalUnitsGroup new.
	policies := GtLZAPoliciesGroup new.
	transitGateways := GtLZATransitGatewaysGroup new.
	routeTables := GtLZARouteTablesGroup new.
	vpcs := GtLZAVPCsGroup new.
	
	metadata := Dictionary new
]

{ #category : #'as yet unclassified' }
GtLZAImporter >> metadata [
	^ metadata
]
