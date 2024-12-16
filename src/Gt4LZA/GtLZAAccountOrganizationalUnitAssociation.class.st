Class {
	#name : #GtLZAAccountOrganizationalUnitAssociation,
	#superclass : #FAMIXAssociation,
	#instVars : [
		'account',
		'organizationalUnit'
	],
	#category : #'Gt4LZA-Model'
}

{ #category : #accessing }
GtLZAAccountOrganizationalUnitAssociation >> account [
	<MSEProperty: #account type: #GtLZAAccount opposite: #organizationalUnitAssociation>
	^ account
]

{ #category : #accessing }
GtLZAAccountOrganizationalUnitAssociation >> account: anObject [
	account == anObject ifTrue: [ ^ self ].
	account ifNotNil: [ account organizationalUnitAssociation: nil ].
	account := anObject.
	account ifNotNil: [ account organizationalUnitAssociation: self ]
]

{ #category : #accessing }
GtLZAAccountOrganizationalUnitAssociation >> from [
	^ self account
]

{ #category : #accessing }
GtLZAAccountOrganizationalUnitAssociation >> organizationalUnit [
	<MSEProperty: #organizationalUnit type: #GtLZAOrganizationalUnit opposite: #accountAssociations>
	^ organizationalUnit
]

{ #category : #accessing }
GtLZAAccountOrganizationalUnitAssociation >> organizationalUnit: anObject [
	organizationalUnit := FMMultivalueLink
			on: self
			update: #accountAssociations
			from: self organizationalUnit
			to: anObject
]

{ #category : #accessing }
GtLZAAccountOrganizationalUnitAssociation >> to [
	^ self organizationalUnit
]
