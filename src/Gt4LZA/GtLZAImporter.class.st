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
		'vpcs',
		'subnets',
		'model',
		'currentFile',
		'files',
		'directories'
	],
	#category : #'Gt4LZA-Importer'
}

{ #category : #accessing }
GtLZAImporter >> directory [
	^ directory
]

{ #category : #accessing }
GtLZAImporter >> directory: anObject [
	directory := anObject.
	model rootFolder: directory
]

{ #category : #importing }
GtLZAImporter >> ensureAccountNamed: accountName [
	^ accounts
		detect: [ :anItem | anItem name = accountName ]
		ifNone: [ | item |
			item := GtLZAAccount new name: accountName.
			item mooseModel: model.
			accounts add: item.
			item ]
]

{ #category : #importing }
GtLZAImporter >> ensureFileNamed: aFileReference [
	| filename |
	filename := aFileReference pathString.
	DiskStore activeClass isCaseSensitive
		ifFalse: [ filename := filename asUppercase ].
	^ files
		at: filename
		ifAbsentPut: [ | file |
			file := FAMIXFile new.
			file name: aFileReference basename.
			aFileReference exists
				ifTrue: [ | encoding anchor |
					encoding := [ aFileReference
							binaryReadStreamDo: [ :in | (ZnCharacterEncoder detectEncoding: in upToEnd) identifier ] ]
							on: Error
							do: [ :ex | ex return: 'utf-8' ].
					anchor := FAMIXIndexedFileEntityAnchor
							file: file
							startPos: 1
							endPos: (aFileReference
									readStreamEncoded: encoding
									do: [ :stream | stream contents size ])
							model: model.
					file sourceAnchor: anchor ]
				ifFalse: [ file isStub: true ].
			(self ensureFolderNamed: aFileReference parent)
				ifNotNil: [ :folder | folder addChildFileSystemEntity: file ].
			model add: file.
			file ]
]

{ #category : #importing }
GtLZAImporter >> ensureFolderNamed: aFileReference [
	^ directories
		at: aFileReference pathString
		ifAbsentPut: [ | folder |
			folder := FAMIXFolder new.
			aFileReference = model rootFolder
				ifTrue: [ folder name: '.' ]
				ifFalse: [ folder name: aFileReference basename.
					(self ensureFolderNamed: aFileReference parent)
						ifNotNil: [ :outer | outer addChildFileSystemEntity: folder ] ].
			model add: folder.
			folder ]
]

{ #category : #importing }
GtLZAImporter >> ensureOrganizationalUnitNamed: aName [
	^ organizationalUnits
		detect: [ :anItem | anItem name = aName ]
		ifNone: [ | item |
			item := GtLZAOrganizationalUnit new name: aName.
			item mooseModel: model.
			organizationalUnits add: item.
			item ]
]

{ #category : #importing }
GtLZAImporter >> ensurePolicyNamed: policyName [
	^ policies
		detect: [ :anItem | anItem name = policyName ]
		ifNone: [ | item |
			item := GtLZAPolicy new name: policyName.
			item mooseModel: model.
			policies add: item.
			item ]
]

{ #category : #importing }
GtLZAImporter >> ensureRouteTableNamed: routeTableName [
	^ routeTables
		detect: [ :anItem | anItem name = routeTableName ]
		ifNone: [ | item |
			item := GtLZARouteTable new name: routeTableName.
			item mooseModel: model.
			routeTables add: item.
			item ]
]

{ #category : #importing }
GtLZAImporter >> ensureSubnetNamed: subnetName [
	^ subnets
		detect: [ :anItem | anItem name = subnetName ]
		ifNone: [ | item |
			item := GtLZASubnet new name: subnetName.
			item mooseModel: model.
			subnets add: item.
			item ]
]

{ #category : #importing }
GtLZAImporter >> ensureTransitGatewayNamed: transitGatewayName [
	^ transitGateways
		detect: [ :anItem | anItem name = transitGatewayName ]
		ifNone: [ | item |
			item := GtLZATransitGateway new name: transitGatewayName.
			item mooseModel: model.
			transitGateways add: item.
			item ]
]

{ #category : #importing }
GtLZAImporter >> ensureVpcNamed: vpcName [
	^ vpcs
		detect: [ :anItem | anItem name = vpcName ]
		ifNone: [ | item |
			item := GtLZAVPC new name: vpcName.
			item mooseModel: model.
			vpcs add: item.
			item ]
]

{ #category : #importing }
GtLZAImporter >> finishImport [
	currentFile := nil
]

{ #category : #views }
GtLZAImporter >> gtAccountsFor: aView [
	<gtView>
	^ aView forward
		title: 'Accounts';
		priority: 1;
		object: [ accounts ];
		view: #gtAccountsFor:
]

{ #category : #views }
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

{ #category : #views }
GtLZAImporter >> gtModelFor: aView [
	<gtView>
	^ aView forward
		title: 'Model';
		object: [ model ];
		view: #gtNavigationFor:
]

{ #category : #views }
GtLZAImporter >> gtNetworkGraphFor: aView [
	<gtView>
	^ aView mondrian
		title: 'Network graph';
		priority: 10;
		painting: [ :m | 
			m nodes
				stencil: [ :anAccount | 
					| childrenContainer |
					childrenContainer := BrHorizontalPane new
							fitContent;
							alignCenter;
							padding: (BlInsets all: 5).
					childrenContainer graph beChildrenContainer: #default.
					BrVerticalPane new
						fitContent;
						border: (BlBorder paint: Color black width: 1);
						addChild: (BrLabel new
								aptitude: BrGlamorousLabelAptitude;
								text: anAccount name);
						addChild: childrenContainer ];
				with: (accounts
						select: [ :anAccount | (anAccount managedEntitiesOfType: GtLZAVPC) isNotEmpty ]);
				forEach: [ :anAccount | 
					anAccount paintOn: m ].

			m edges
				connect: (transitGateways
						flatCollect: [ :aTransitGateway | 
							aTransitGateway attachments
								flatCollect: [ :anAttachment | 
									anAttachment routeTableAssociations
										collect: [ :anAssociation | anAssociation -> anAttachment subnets ] ] ])
				from: #key
				toAll: #value ]
]

{ #category : #views }
GtLZAImporter >> gtOrganizationalUnitsFor: aView [
	<gtView>
	^ aView forward
		title: 'Organizational units';
		priority: 2;
		object: [ organizationalUnits ];
		view: #gtOrganizationalUnitsFor:
]

{ #category : #views }
GtLZAImporter >> gtPoliciesFor: aView [
	<gtView>
	^ aView forward
		title: 'Policies';
		priority: 3;
		object: [ policies ];
		view: #gtPoliciesFor:
]

{ #category : #views }
GtLZAImporter >> gtRouteTablesFor: aView [
	<gtView>
	^ aView forward
		title: 'Route tables';
		priority: 3;
		object: [ routeTables ];
		view: #gtRouteTablesFor:
]

{ #category : #views }
GtLZAImporter >> gtTransitGatewaysFor: aView [
	<gtView>
	^ aView forward
		title: 'Transit gateways';
		priority: 4;
		object: [ transitGateways ];
		view: #gtTransitGatewaysFor:
]

{ #category : #views }
GtLZAImporter >> gtVpcsFor: aView [
	<gtView>
	^ aView forward
		title: 'VPCs';
		priority: 1;
		object: [ vpcs ];
		view: #gtVpcsFor:
]

{ #category : #importing }
GtLZAImporter >> import [
	self assert: directory isNotNil description: 'Import directory must be set'.
	self assert: directory exists description: 'Import directory must exist'.
	
	self importOrganization.
	self importAccounts.
	self importNetwork.
	
	self finishImport
]

{ #category : #importing }
GtLZAImporter >> importAccounts [
	| file ast |
	file := directory / 'accounts-config.yaml'.

	file
		ifExists: [ currentFile := self ensureFileNamed: file.
			ast := YAMLParser parseFile: file.
			ast object
				keysAndValuesDo: [ :aKey :aList | 
					aList
						do: [ :anAccount | 
							(self ensureAccountNamed: (anAccount at: 'name'))
								sourceAnchor: (self sourceAnchorFor: (ast nodeForObject: anAccount));
								rawData: anAccount;
								description: (anAccount at: 'description');
								email: (anAccount at: 'email');
								organizationalUnit: (self ensureOrganizationalUnitNamed: (anAccount at: 'organizationalUnit'));
								type: aKey ] ] ]
]

{ #category : #importing }
GtLZAImporter >> importNetwork [
	| file ast |
	file := directory / 'network-config.yaml'.
	currentFile := self ensureFileNamed: file.
	ast := YAMLParser parseFile: file.

	self metadata at: 'Home region' put: (ast object at: 'homeRegion').

	self metadata at: 'Default VPC' put: (ast object at: 'defaultVpc').

	self metadata at: 'VPC Flow Logs' put: (ast object at: 'vpcFlowLogs').

	self importTransitGatewaysFrom: ast.
	self importVpcsFrom: ast
]

{ #category : #importing }
GtLZAImporter >> importOrganization [
	| file ast |
	file := directory / 'organization-config.yaml'.

	file
		ifExists: [ currentFile := self ensureFileNamed: file.
			ast := YAMLParser parseFile: file.
			self metadata at: 'Organization enabled' put: (ast object at: 'enable').

			(ast object at: 'organizationalUnits')
				do: [ :anOu | 
					(self ensureOrganizationalUnitNamed: (anOu at: 'name'))
						sourceAnchor: (self sourceAnchorFor: (ast nodeForObject: anOu));
						rawData: anOu ].

			{'serviceControlPolicies'.
				'taggingPolicies'.
				'backupPolicies'}
				do: [ :aPolicyKey | 
					(ast object at: aPolicyKey)
						do: [ :aPolicy | 
							(self ensurePolicyNamed: (aPolicy at: 'name'))
								sourceAnchor: (self sourceAnchorFor: (ast nodeForObject: aPolicy));
								rawData: aPolicy;
								description: (aPolicy at: 'description');
								policy: self directory / (aPolicy at: 'policy');
								type: (aPolicy at: 'type' ifAbsent: [ '' ]);
								organizationalUnits: ((aPolicy at: 'deploymentTargets' at: 'organizationalUnits')
										collect: [ :aName | self ensureOrganizationalUnitNamed: aName ]) ] ] ]
]

{ #category : #importing }
GtLZAImporter >> importTransitGatewaysFrom: ast [
	| transitGateway gatewayRouteTables |
	(ast object at: 'transitGateways')
		do: [ :aGateway | 
			gatewayRouteTables := GtLZARouteTablesGroup
					withAll: ((aGateway at: 'routeTables')
							collect: [ :aRouteTable | 
								(self ensureRouteTableNamed: (aRouteTable at: 'name'))
									sourceAnchor: (self sourceAnchorFor: (ast nodeForObject: aRouteTable));
									rawData: aRouteTable;
									routes: ((aRouteTable at: 'routes')
											collect: [ :aRoute | 
												GtLZAGatewayRoute new
													sourceAnchor: (self sourceAnchorFor: (ast nodeForObject: aRoute));
													destinationCidrBlock: (aRoute at: 'destinationCidrBlock');
													vpc: (self ensureVpcNamed: (aRoute at: 'attachment' at: 'vpcName'));
													account: (self ensureAccountNamed: (aRoute at: 'attachment' at: 'account')) ]) ]).
			routeTables addAll: gatewayRouteTables.
			transitGateway := self ensureTransitGatewayNamed: (aGateway at: 'name').
			transitGateway
				sourceAnchor: (self sourceAnchorFor: (ast nodeForObject: aGateway));
				rawData: aGateway;
				account: (self ensureAccountNamed: (aGateway at: 'account'));
				region: (aGateway at: 'region');
				asn: (aGateway at: 'asn');
				dnsSupport: (aGateway at: 'dnsSupport') = 'enable';
				defaultRouteTableAssociation: (aGateway at: 'defaultRouteTableAssociation') = 'enable';
				defaultRouteTablePropagation: (aGateway at: 'defaultRouteTablePropagation') = 'enable';
				autoAcceptSharingAttachments: (aGateway at: 'autoAcceptSharingAttachments') = 'enable';
				routeTables: gatewayRouteTables;
				shareTargets: (GtLZAShareTarget new
						mooseModel: model;
						accounts: (GtLZAAccountsGroup
								withAll: ((aGateway
										at: 'shareTargets'
										at: 'accounts'
										ifAbsent: [ {} ]) collect: [ :aName | self ensureAccountNamed: aName ]));
						organizationalUnits: (GtLZAOrganizationalUnitsGroup
								withAll: ((aGateway
										at: 'shareTargets'
										at: 'organizationalUnits'
										ifAbsent: [ {} ])
										collect: [ :aName | (self ensureOrganizationalUnitNamed: aName) addChild: transitGateway ]))) ]
]

{ #category : #importing }
GtLZAImporter >> importVpcsFrom: ast [
	| vpcRouteTables vpcNatGateways |
	(ast object at: 'vpcs')
		do: [ :aVpc | 
			vpcRouteTables := GtLZARouteTablesGroup
					withAll: ((aVpc at: 'routeTables')
							collect: [ :aRouteTable | 
								(self ensureRouteTableNamed: (aRouteTable at: 'name'))
									sourceAnchor: (self sourceAnchorFor: (ast nodeForObject: aRouteTable));
									rawData: aRouteTable;
									routes: ((aRouteTable at: 'routes')
											collect: [ :aRoute | 
												GtLZARoute new
													name: (aRoute at: 'name');
													sourceAnchor: (self sourceAnchorFor: (ast nodeForObject: aRoute));
													destination: (aRoute at: 'destination' ifAbsent: [ '' ]);
													type: (aRoute at: 'type');
													target: (aRoute at: 'target') ]) ]).

			vpcNatGateways := GtLZANatGatewaysGroup
					withAll: ((aVpc at: 'natGateways' ifAbsent: [ {} ])
							collect: [ :aNatGateway | 
								GtLZANatGateway new
									sourceAnchor: (self sourceAnchorFor: (ast nodeForObject: aNatGateway));
									rawData: aNatGateway;
									name: (aNatGateway at: 'name');
									subnet: (self ensureSubnetNamed: (aNatGateway at: 'subnet')) ]).

			routeTables addAll: vpcRouteTables.
			(self ensureVpcNamed: (aVpc at: 'name'))
				sourceAnchor: (self sourceAnchorFor: (ast nodeForObject: aVpc));
				rawData: aVpc;
				account: (self ensureAccountNamed: (aVpc at: 'account'));
				region: (aVpc at: 'region');
				cidrs: (aVpc at: 'cidrs');
				internetGateway: (aVpc at: 'internetGateway' ifAbsent: [ false ]);
				enableDnsHostnames: (aVpc at: 'enableDnsHostnames' ifAbsent: [ false ]);
				enableDnsSupport: (aVpc at: 'enableDnsSupport' ifAbsent: [ false ]);
				instanceTenancy: (aVpc at: 'instanceTenancy' ifAbsent: [ false ]);
				queryLogs: (aVpc at: 'queryLogs' ifAbsent: [ {} ]);
				routeTables: vpcRouteTables;
				natGateways: vpcNatGateways;
				subnets: (GtLZASubnetsGroup
						withAll: ((aVpc at: 'subnets')
								collect: [ :aSubnet | 
									| subnetName |
									subnetName := aSubnet at: 'name'.
									(self ensureSubnetNamed: subnetName)
										sourceAnchor: (self sourceAnchorFor: (ast nodeForObject: aSubnet));
										rawData: aSubnet;
										availabilityZone: (aSubnet at: 'availabilityZone');
										ipv4CidrBlock: (aSubnet at: 'ipv4CidrBlock');
										routeTable: (self ensureRouteTableNamed: (aSubnet at: 'routeTable')) ]));
				transitGatewayAttachments: (GtLZATransitGatewayAttachmentsGroup
						withAll: ((aVpc at: 'transitGatewayAttachments')
								collect: [ :anAttachment | 
									GtLZATransitGatewayAttachment new
										sourceAnchor: (self sourceAnchorFor: (ast nodeForObject: anAttachment));
										rawData: anAttachment;
										name: (anAttachment at: 'name');
										transitGateway: (self ensureTransitGatewayNamed: (anAttachment at: 'transitGateway' at: 'name'));
										routeTableAssociations: (GtLZARouteTablesGroup
												withAll: ((anAttachment at: 'routeTableAssociations')
														collect: [ :aName | self ensureRouteTableNamed: aName ]));
										routeTablePropagations: (GtLZARouteTablesGroup
												withAll: ((anAttachment at: 'routeTablePropagations')
														collect: [ :aName | self ensureRouteTableNamed: aName ]));
										subnets: (GtLZASubnetsGroup
												withAll: ((anAttachment at: 'subnets')
														collect: [ :aName | self ensureSubnetNamed: aName ])) ]));
				gatewayEndpoints: (aVpc at: 'gatewayEndpoints');
				interfaceEndpoints: (aVpc at: 'interfaceEndpoints' ifAbsent: [ nil ]) ]
]

{ #category : #initialization }
GtLZAImporter >> initialize [
	super initialize.
	model := MooseModel new.
	model sourceLanguage: GtLZASourceLanguage new.
	directories := Dictionary new.
	files := Dictionary new.
	accounts := GtLZAAccountsGroup new.
	organizationalUnits := GtLZAOrganizationalUnitsGroup new.
	policies := GtLZAPoliciesGroup new.
	transitGateways := GtLZATransitGatewaysGroup new.
	routeTables := GtLZARouteTablesGroup new.
	vpcs := GtLZAVPCsGroup new.
	subnets := GtLZASubnetsGroup new.

	metadata := Dictionary new
]

{ #category : #accessing }
GtLZAImporter >> metadata [
	^ metadata
]

{ #category : #importing }
GtLZAImporter >> sourceAnchorFor: aNode [
	aNode ifNil: [ ^ nil ].
	^ FAMIXIndexedFileEntityAnchor
		file: currentFile
		startPos: aNode startPosition
		endPos: aNode stopPosition
		model: model
]
