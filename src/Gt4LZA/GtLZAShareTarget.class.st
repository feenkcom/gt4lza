Class {
	#name : #GtLZAShareTarget,
	#superclass : #Object,
	#instVars : [
		'accounts',
		'organizationalUnits'
	],
	#category : #'Gt4LZA-Model'
}

{ #category : #accessing }
GtLZAShareTarget >> accounts [
	^ accounts
]

{ #category : #accessing }
GtLZAShareTarget >> accounts: anObject [
	accounts := anObject
]

{ #category : #'as yet unclassified' }
GtLZAShareTarget >> gtAccountsFor: aView [
	<gtView>
	^ aView forward
		title: 'Accounts';
		priority: 1;
		object: [ self accounts ];
		view: #gtAccountsFor:
]

{ #category : #'as yet unclassified' }
GtLZAShareTarget >> gtOrganizationalUnitsFor: aView [
	<gtView>
	^ aView forward
		title: 'Organizational units';
		priority: 1;
		object: [ self organizationalUnits ];
		view: #gtOrganizationalUnitsFor:
]

{ #category : #accessing }
GtLZAShareTarget >> organizationalUnits [
	^ organizationalUnits
]

{ #category : #accessing }
GtLZAShareTarget >> organizationalUnits: anObject [
	organizationalUnits := anObject
]
