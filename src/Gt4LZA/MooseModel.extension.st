Extension { #name : #MooseModel }

{ #category : #'*Gt4LZA' }
MooseModel >> allLZAAccounts [
	<navigation: 'All LZA accounts'>
	^ self allWithType: GtLZAAccount
]

{ #category : #'*Gt4LZA' }
MooseModel >> allLZAGatewayRoutes [
	<navigation: 'All LZA gateway routes'>
	^ self allWithType: GtLZAGatewayRoute
]

{ #category : #'*Gt4LZA' }
MooseModel >> allLZANatGateways [
	<navigation: 'All LZA nat gateways'>
	^ self allWithType: GtLZANatGateway
]

{ #category : #'*Gt4LZA' }
MooseModel >> allLZAOrganizationalUnits [
	<navigation: 'All LZA organizational units'>
	^ self allWithType: GtLZAOrganizationalUnit
]

{ #category : #'*Gt4LZA' }
MooseModel >> allLZAPolicies [
	<navigation: 'All LZA policies'>
	^ self allWithType: GtLZAPolicy
]

{ #category : #'*Gt4LZA' }
MooseModel >> allLZARouteTables [
	<navigation: 'All LZA route tables'>
	^ self allWithType: GtLZARouteTable
]

{ #category : #'*Gt4LZA' }
MooseModel >> allLZARoutes [
	<navigation: 'All LZA routes'>
	^ self allWithType: GtLZARoute
]

{ #category : #'*Gt4LZA' }
MooseModel >> allLZASubnets [
	<navigation: 'All LZA subnets'>
	^ self allWithType: GtLZASubnet
]

{ #category : #'*Gt4LZA' }
MooseModel >> allLZATransitGatewayAttachments [
	<navigation: 'All LZA transit gateway attachments'>
	^ self allWithType: GtLZATransitGatewayAttachment
]

{ #category : #'*Gt4LZA' }
MooseModel >> allLZATransitGateways [
	<navigation: 'All LZA transit gateways'>
	^ self allWithType: GtLZATransitGateway
]

{ #category : #'*Gt4LZA' }
MooseModel >> allLZAVPCs [
	<navigation: 'All LZA VPCs'>
	^ self allWithType: GtLZAVPC
]
