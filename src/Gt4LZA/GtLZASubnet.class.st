Class {
	#name : #GtLZASubnet,
	#superclass : #GtLZAEntity,
	#instVars : [
		'availabilityZone',
		'ipv4CidrBlock',
		'routeTable'
	],
	#category : #'Gt4LZA-Model'
}

{ #category : #accessing }
GtLZASubnet >> availabilityZone [
	^ availabilityZone
]

{ #category : #accessing }
GtLZASubnet >> availabilityZone: anObject [
	availabilityZone := anObject
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
	routeTable := anObject
]
