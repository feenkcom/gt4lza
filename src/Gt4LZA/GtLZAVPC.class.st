Class {
	#name : #GtLZAVPC,
	#superclass : #GtLZAEntity,
	#instVars : [
		'account',
		'region',
		'cidrs',
		'internetGateway',
		'enableDnsHostnames',
		'enableDnsSupport',
		'instanceTenancy',
		'queryLogs',
		'routeTables',
		'subnets',
		'transitGatewayAttachments',
		'gatewayEndpoints',
		'interfaceEndpoints',
		'natGateways',
		'gatewayRoutes'
	],
	#category : #'Gt4LZA-Model'
}

{ #category : #accessing }
GtLZAVPC >> account [
	^ account
]

{ #category : #accessing }
GtLZAVPC >> account: anObject [
	account := anObject.
	account addManagedEntity: self
]

{ #category : #adding }
GtLZAVPC >> addGatewayRoute: aRoute [
	gatewayRoutes add: aRoute
]

{ #category : #accessing }
GtLZAVPC >> cidrs [
	^ cidrs
]

{ #category : #accessing }
GtLZAVPC >> cidrs: anObject [
	cidrs := anObject
]

{ #category : #accessing }
GtLZAVPC >> enableDnsHostnames [
	^ enableDnsHostnames
]

{ #category : #accessing }
GtLZAVPC >> enableDnsHostnames: anObject [
	enableDnsHostnames := anObject
]

{ #category : #accessing }
GtLZAVPC >> enableDnsSupport [
	^ enableDnsSupport
]

{ #category : #accessing }
GtLZAVPC >> enableDnsSupport: anObject [
	enableDnsSupport := anObject
]

{ #category : #accessing }
GtLZAVPC >> gatewayEndpoints [
	^ gatewayEndpoints
]

{ #category : #accessing }
GtLZAVPC >> gatewayEndpoints: anObject [
	gatewayEndpoints := anObject
]

{ #category : #accessing }
GtLZAVPC >> gatewayRoutes [
	^ gatewayRoutes
]

{ #category : #accessing }
GtLZAVPC >> gatewayRoutes: anObject [
	gatewayRoutes := anObject
]

{ #category : #views }
GtLZAVPC >> gtRouteTablesFor: aView [
	<gtView>
	^ aView forward
		title: 'Route tables';
		priority: 1;
		object: [ routeTables ];
		view: #gtRouteTablesFor:
]

{ #category : #views }
GtLZAVPC >> gtSubnetsFor: aView [
	<gtView>
	^ aView forward
		title: 'Subnets';
		priority: 5;
		object: [ subnets ];
		view: #gtSubnetsFor:
]

{ #category : #views }
GtLZAVPC >> gtTransitGatewayAttachmentsFor: aView [
	<gtView>
	^ aView forward
		title: 'Transit gateway attachments';
		priority: 2;
		object: [ transitGatewayAttachments ];
		view: #gtTransitGatewayAttachmentsFor:
]

{ #category : #initialization }
GtLZAVPC >> initialize [
	super initialize.

	gatewayRoutes := GtLZAGatewayRoutesGroup new
]

{ #category : #accessing }
GtLZAVPC >> instanceTenancy [
	^ instanceTenancy
]

{ #category : #accessing }
GtLZAVPC >> instanceTenancy: anObject [
	instanceTenancy := anObject
]

{ #category : #accessing }
GtLZAVPC >> interfaceEndpoints [
	^ interfaceEndpoints
]

{ #category : #accessing }
GtLZAVPC >> interfaceEndpoints: anObject [
	interfaceEndpoints := anObject
]

{ #category : #accessing }
GtLZAVPC >> internetGateway [
	^ internetGateway
]

{ #category : #accessing }
GtLZAVPC >> internetGateway: anObject [
	internetGateway := anObject
]

{ #category : #accessing }
GtLZAVPC >> natGateways [
	^ natGateways
]

{ #category : #accessing }
GtLZAVPC >> natGateways: anObject [
	natGateways := anObject
]

{ #category : #accessing }
GtLZAVPC >> paintOn: m [
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
						margin: (BlInsets all: 5);
						border: (BlBorder paint: Color lightBlue width: 2);
						addChild: (BrLabel new
								aptitude: BrGlamorousLabelAptitude;
								text: 'Availability Zone ', anAccount name);
						addChild: childrenContainer ];
		with: self subnetsByAvailabilityZone associations;
		forEach: [ :anAssociation | 
			m nodes
				labelled: #name;
				with: anAssociation value.
			m layout vertical ].
	m layout vertical
]

{ #category : #accessing }
GtLZAVPC >> queryLogs [
	^ queryLogs
]

{ #category : #accessing }
GtLZAVPC >> queryLogs: anObject [
	queryLogs := anObject
]

{ #category : #accessing }
GtLZAVPC >> region [
	^ region
]

{ #category : #accessing }
GtLZAVPC >> region: anObject [
	region := anObject
]

{ #category : #accessing }
GtLZAVPC >> routeTables [
	^ routeTables
]

{ #category : #accessing }
GtLZAVPC >> routeTables: anObject [
	routeTables := anObject
]

{ #category : #accessing }
GtLZAVPC >> subnets [
	^ subnets
]

{ #category : #accessing }
GtLZAVPC >> subnets: anObject [
	subnets := anObject
]

{ #category : #accessing }
GtLZAVPC >> subnetsByAvailabilityZone [
	^ subnets groupedBy: #availabilityZone
]

{ #category : #accessing }
GtLZAVPC >> transitGatewayAttachments [
	^ transitGatewayAttachments
]

{ #category : #accessing }
GtLZAVPC >> transitGatewayAttachments: anObject [
	transitGatewayAttachments := anObject
]
