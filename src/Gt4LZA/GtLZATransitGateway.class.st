Class {
	#name : #GtLZATransitGateway,
	#superclass : #GtLZAEntity,
	#instVars : [
		'account',
		'region',
		'shareTargets',
		'asn',
		'dnsSupport',
		'vpnEcmpSupport',
		'defaultRouteTableAssociation',
		'defaultRouteTablePropagation',
		'autoAcceptSharingAttachments',
		'routeTables',
		'attachments'
	],
	#category : #'Gt4LZA-Model'
}

{ #category : #accessing }
GtLZATransitGateway >> account [
	^ account
]

{ #category : #accessing }
GtLZATransitGateway >> account: anObject [
	account := anObject.
	account addManagedEntity: self
]

{ #category : #'as yet unclassified' }
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

{ #category : #'as yet unclassified' }
GtLZATransitGateway >> initialize [
	super initialize.
	
	attachments := GtLZATransitGatewayAttachmentsGroup new
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

{ #category : #'as yet unclassified' }
GtLZATransitGateway >> subnetsByAvailabilityZone [
	^ {} asDictionary
]

{ #category : #accessing }
GtLZATransitGateway >> vpnEcmpSupport [
	^ vpnEcmpSupport
]

{ #category : #accessing }
GtLZATransitGateway >> vpnEcmpSupport: anObject [
	vpnEcmpSupport := anObject
]
