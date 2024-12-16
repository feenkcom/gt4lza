Class {
	#name : #GtLZAAccountVPCAssociation,
	#superclass : #FAMIXAssociation,
	#instVars : [
		'account',
		'vpc'
	],
	#category : #'Gt4LZA-Model'
}

{ #category : #accessing }
GtLZAAccountVPCAssociation >> account [
	<MSEProperty: #account type: #GtLZAAccount opposite: #vpcAssociations>
	^ account
]

{ #category : #accessing }
GtLZAAccountVPCAssociation >> account: anObject [
	account := FMMultivalueLink
			on: self
			update: #vpcAssociations
			from: self account
			to: anObject
]

{ #category : #accessing }
GtLZAAccountVPCAssociation >> from [
	^ self vpc
]

{ #category : #accessing }
GtLZAAccountVPCAssociation >> to [
	^ self account
]

{ #category : #accessing }
GtLZAAccountVPCAssociation >> vpc [
	<MSEProperty: #vpc type: #GtLZAVPC opposite: #accountAssociation>
	^ vpc
]

{ #category : #accessing }
GtLZAAccountVPCAssociation >> vpc: anObject [
	vpc == anObject ifTrue: [ ^ self ].
	vpc ifNotNil: [ vpc accountAssociation: nil ].
	vpc := anObject.
	vpc ifNotNil: [ vpc accountAssociation: self ]
]
