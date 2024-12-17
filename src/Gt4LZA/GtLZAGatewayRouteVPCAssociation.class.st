Class {
	#name : #GtLZAGatewayRouteVPCAssociation,
	#superclass : #FAMIXAssociation,
	#instVars : [
		'gatewayRoute',
		'vpc'
	],
	#category : #'Gt4LZA-Model'
}

{ #category : #accessing }
GtLZAGatewayRouteVPCAssociation >> from [
	^ self gatewayRoute
]

{ #category : #accessing }
GtLZAGatewayRouteVPCAssociation >> gatewayRoute [
	<MSEProperty: #gatewayRoute type: #GtLZAGatewayRoute opposite: #vpcAssociation>
	^ gatewayRoute
]

{ #category : #accessing }
GtLZAGatewayRouteVPCAssociation >> gatewayRoute: anObject [
	gatewayRoute == anObject ifTrue: [ ^ self ].
	gatewayRoute ifNotNil: [ gatewayRoute vpcAssociation: nil ].
	gatewayRoute := anObject.
	gatewayRoute ifNotNil: [ gatewayRoute vpcAssociation: self ]
]

{ #category : #accessing }
GtLZAGatewayRouteVPCAssociation >> to [
	^ self vpc
]

{ #category : #accessing }
GtLZAGatewayRouteVPCAssociation >> vpc [
	<MSEProperty: #vpc type: #GtLZAVPC opposite: #gatewayRouteAssociations>
	^ vpc
]

{ #category : #accessing }
GtLZAGatewayRouteVPCAssociation >> vpc: anObject [
	vpc := FMMultivalueLink
			on: self
			update: #gatewayRouteAssociations
			from: self vpc
			to: anObject
]
