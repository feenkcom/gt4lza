Class {
	#name : #GtLZASubnet,
	#superclass : #GtLZAEntity,
	#instVars : [
		'availabilityZone',
		'ipv4CidrBlock',
		'routeTable',
		'transitGatewayAttachments'
	],
	#category : #'Gt4LZA-Model'
}

{ #category : #'as yet unclassified' }
GtLZASubnet >> addTransitGatewayAttachment: anAttachment [ 
	transitGatewayAttachments add: anAttachment
]

{ #category : #accessing }
GtLZASubnet >> availabilityZone [
	^ availabilityZone
]

{ #category : #accessing }
GtLZASubnet >> availabilityZone: anObject [
	availabilityZone := anObject
]

{ #category : #'as yet unclassified' }
GtLZASubnet >> initialize [
	super initialize.
	
	transitGatewayAttachments := GtLZATransitGatewayAttachmentsGroup new
]

{ #category : #accessing }
GtLZASubnet >> ipv4CidrBlock [
	^ ipv4CidrBlock
]

{ #category : #accessing }
GtLZASubnet >> ipv4CidrBlock: anObject [
	ipv4CidrBlock := anObject
]

{ #category : #accessing }
GtLZASubnet >> routeTable [
	^ routeTable
]

{ #category : #accessing }
GtLZASubnet >> routeTable: anObject [
	routeTable := anObject.
	routeTable addSubnet: self
]

{ #category : #accessing }
GtLZASubnet >> transitGatewayAttachments [
	^ transitGatewayAttachments
]

{ #category : #accessing }
GtLZASubnet >> transitGatewayAttachments: anObject [
	transitGatewayAttachments := anObject
]
