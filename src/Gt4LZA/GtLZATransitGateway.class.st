Class {
	#name : #GtLZATransitGateway,
	#superclass : #GtLZAEntity,
	#instVars : [
		'region',
		'shareTargets',
		'asn',
		'dnsSupport',
		'vpnEcmpSupport',
		'defaultRouteTableAssociation',
		'defaultRouteTablePropagation',
		'autoAcceptSharingAttachments',
		'routeTables',
		'attachments',
		'accountAssociation',
		'organizationalUnitAssociations'
	],
	#category : #'Gt4LZA-Model'
}

{ #category : #accessing }
GtLZATransitGateway >> account [
	^ accountAssociation ifNil: [ accountAssociation account ]
]

{ #category : #accessing }
GtLZATransitGateway >> accountAssociation [
	<MSEProperty: #accountAssociation type: #GtLZAAccountTransitGatewayAssociation opposite: #transitGateway>
	^ accountAssociation
]

{ #category : #accessing }
GtLZATransitGateway >> accountAssociation: anObject [
	accountAssociation := anObject
]

{ #category : #adding }
GtLZATransitGateway >> addAttachment: anAttachment [
	attachments add: anAttachment
]

{ #category : #accessing }
GtLZATransitGateway >> asn [
	^ asn
]

{ #category : #accessing }
GtLZATransitGateway >> asn: anObject [
	asn := anObject
]

{ #category : #accessing }
GtLZATransitGateway >> attachments [
	^ attachments
]

{ #category : #accessing }
GtLZATransitGateway >> attachments: anObject [
	attachments := anObject
]

{ #category : #accessing }
GtLZATransitGateway >> autoAcceptSharingAttachments [
	^ autoAcceptSharingAttachments
]

{ #category : #accessing }
GtLZATransitGateway >> autoAcceptSharingAttachments: anObject [
	autoAcceptSharingAttachments := anObject
]

{ #category : #accessing }
GtLZATransitGateway >> defaultRouteTableAssociation [
	^ defaultRouteTableAssociation
]

{ #category : #accessing }
GtLZATransitGateway >> defaultRouteTableAssociation: anObject [
	defaultRouteTableAssociation := anObject
]

{ #category : #accessing }
GtLZATransitGateway >> defaultRouteTablePropagation [
	^ defaultRouteTablePropagation
]

{ #category : #accessing }
GtLZATransitGateway >> defaultRouteTablePropagation: anObject [
	defaultRouteTablePropagation := anObject
]

{ #category : #accessing }
GtLZATransitGateway >> dnsSupport [
	^ dnsSupport
]

{ #category : #accessing }
GtLZATransitGateway >> dnsSupport: anObject [
	dnsSupport := anObject
]

{ #category : #initialization }
GtLZATransitGateway >> initialize [
	super initialize.
	organizationalUnitAssociations := FMNullMultivalueLink
			on: self
			opposite: #transitGateway:
			selector: #organizationalUnitAssociations.
	attachments := GtLZATransitGatewayAttachmentsGroup new
]

{ #category : #accessing }
GtLZATransitGateway >> organizationalUnitAssociations [
	<MSEProperty: #organizationalUnitAssociations type: #GtLZAOrganizationalUnitTransitGatewayAssociation opposite: #transitGateway>
	<multivalued>
	^ organizationalUnitAssociations
]

{ #category : #accessing }
GtLZATransitGateway >> paintOn: m [
	m nodes
		stencil: [ :anAccount | 
			| childrenContainer |
			childrenContainer := BrHorizontalPane new
					fitContent;
					alignCenter.
			childrenContainer graph beChildrenContainer: #default.
			BrVerticalPane new
				fitContent;
				padding: (BlInsets all: 5);
				margin: (BlInsets all: 10);
				aptitude: BrShadowAptitude new;
				background: (Color purple veryMuchLighter);
				addChild: (BrLabel new
						aptitude: BrGlamorousLabelAptitude;
						text: anAccount name);
				addChild: childrenContainer ];
		with: self routeTables.
	m layout vertical
]

{ #category : #accessing }
GtLZATransitGateway >> region [
	^ region
]

{ #category : #accessing }
GtLZATransitGateway >> region: anObject [
	region := anObject
]

{ #category : #accessing }
GtLZATransitGateway >> routeTables [
	^ routeTables
]

{ #category : #accessing }
GtLZATransitGateway >> routeTables: anObject [
	routeTables := anObject.
	
	routeTables do: [:aRouteTable | aRouteTable parent: self]
]

{ #category : #accessing }
GtLZATransitGateway >> shareTargets [
	^ shareTargets
]

{ #category : #accessing }
GtLZATransitGateway >> shareTargets: anObject [
	shareTargets := anObject
]

{ #category : #accessing }
GtLZATransitGateway >> vpnEcmpSupport [
	^ vpnEcmpSupport
]

{ #category : #accessing }
GtLZATransitGateway >> vpnEcmpSupport: anObject [
	vpnEcmpSupport := anObject
]
