Class {
	#name : #GtLZAAccount,
	#superclass : #GtLZAEntity,
	#instVars : [
		'description',
		'email',
		'type',
		'organizationalUnitAssociation',
		'gatewayRouteAssociations',
		'transitGatewayAssociations',
		'vpcAssociations'
	],
	#category : #'Gt4LZA-Model'
}

{ #category : #accessing }
GtLZAAccount >> description [
	^ description
]

{ #category : #accessing }
GtLZAAccount >> description: anObject [
	description := anObject
]

{ #category : #accessing }
GtLZAAccount >> email [
	^ email
]

{ #category : #accessing }
GtLZAAccount >> email: anObject [
	email := anObject
]

{ #category : #accessing }
GtLZAAccount >> gatewayRouteAssociations [
	<MSEProperty: #gatewayRouteAssociations type: #GtLZAAccountGatewayRouteAssociation opposite: #account>
	^ gatewayRouteAssociations
]

{ #category : #accessing }
GtLZAAccount >> gatewayRoutes [
	^ gatewayRouteAssociations collect: #gatewayRoute
]

{ #category : #views }
GtLZAAccount >> gtManagedEntitiesFor: aView [
	<gtView>
	^ aView forward
		title: 'Managed entities';
		priority: 1;
		object: [ self managedEntities ];
		view: #gtEntitiesFor:
]

{ #category : #initialization }
GtLZAAccount >> initialize [
	super initialize.
	gatewayRouteAssociations := FMNullMultivalueLink
			on: self
			opposite: #accountAssociation:
			selector: #gatewayRouteAssociations.
	transitGatewayAssociations := FMNullMultivalueLink
			on: self
			opposite: #accountAssociation:
			selector: #transitGatewayAssociations.
	vpcAssociations := FMNullMultivalueLink
			on: self
			opposite: #accountAssociation:
			selector: #vpcAssociations
]

{ #category : #accessing }
GtLZAAccount >> managedEntities [
	^ GtLZAEntitiesGroup new
		addAll: self gatewayRoutes;
		addAll: self transitGateways;
		addAll: self vpcs;
		yourself
]

{ #category : #accessing }
GtLZAAccount >> managedEntitiesOfType: aClass [
	^ self managedEntities select: [ :anEntity | anEntity isKindOf: aClass ]
]

{ #category : #accessing }
GtLZAAccount >> organizationalUnit [
	^ organizationalUnitAssociation
		ifNotNil: [ organizationalUnitAssociation organizationalUnit ]
]

{ #category : #accessing }
GtLZAAccount >> organizationalUnitAssociation [
	<MSEProperty: #organizationalUnitAssociation type: #GtLZAAccountOrganizationalUnitAssociation opposite: #account>
	^ organizationalUnitAssociation
]

{ #category : #accessing }
GtLZAAccount >> organizationalUnitAssociation: anObject [
	organizationalUnitAssociation := anObject
]

{ #category : #accessing }
GtLZAAccount >> paintOn: m [
	m nodes
		stencil: [ :anAccount | 
			| childrenContainer |
			childrenContainer := BrHorizontalPane new
					fitContent;
					alignCenter";
					padding: (BlInsets all: 5)".
			childrenContainer graph beChildrenContainer: #default.
			BrVerticalPane new
				fitContent;
				margin: (BlInsets all: 5);
				padding: (BlInsets all: 5);
				aptitude: BrShadowAptitude new;
				background: Color white;
				addChild: (BrLabel new
						aptitude: BrGlamorousLabelAptitude;
						text: (anAccount name asRopedText), (' VPCs' asRopedText
								foreground: Color gray;
								glamorousRegularSmallSize));
				addChild: childrenContainer ];
		with: (self managedEntitiesOfType: GtLZAVPC);
		forEach: [ :aVpc | aVpc paintOn: m ].
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
				padding: (BlInsets all: 5);
				aptitude: BrShadowAptitude new;
				background: Color white;
				addChild: (BrLabel new
						aptitude: BrGlamorousLabelAptitude;
						text: (anAccount name asRopedText), (' Gateways' asRopedText
								foreground: Color gray;
								glamorousRegularSmallSize));
				addChild: childrenContainer ];
		with: (self managedEntitiesOfType: GtLZATransitGateway)
			forEach: [ :aTransitGateway | aTransitGateway paintOn: m ].
	m layout horizontal
]

{ #category : #accessing }
GtLZAAccount >> transitGatewayAssociations [
	<MSEProperty: #transitGatewayAssociations type: #GtLZAAccountTransitGatewayAssociation opposite: #account>
	^ transitGatewayAssociations
]

{ #category : #accessing }
GtLZAAccount >> transitGateways [
	^ transitGatewayAssociations collect: #transitGateway
]

{ #category : #accessing }
GtLZAAccount >> type [
	^ type
]

{ #category : #accessing }
GtLZAAccount >> type: anObject [
	type := anObject
]

{ #category : #accessing }
GtLZAAccount >> vpcAssociations [
	<MSEProperty: #vpcAssociations type: #GtLZAAccountVPCAssociation opposite: #account>
	^ vpcAssociations
]

{ #category : #accessing }
GtLZAAccount >> vpcs [
	^ vpcAssociations collect: #vpc
]
