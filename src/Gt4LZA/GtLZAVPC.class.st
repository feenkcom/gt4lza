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
		'interfaceEndpoints'
	],
	#category : #'Gt4LZA-Model'
}

{ #category : #accessing }
GtLZAVPC >> account [
	^ account
]

{ #category : #accessing }
GtLZAVPC >> account: anObject [
	account := anObject
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
GtLZAVPC >> transitGatewayAttachments [
	^ transitGatewayAttachments
]

{ #category : #accessing }
GtLZAVPC >> transitGatewayAttachments: anObject [
	transitGatewayAttachments := anObject
]
