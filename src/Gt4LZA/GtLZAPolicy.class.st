Class {
	#name : #GtLZAPolicy,
	#superclass : #GtLZAEntity,
	#instVars : [
		'description',
		'policy',
		'type',
		'organizationalUnitAssociations'
	],
	#category : #'Gt4LZA-Model'
}

{ #category : #accessing }
GtLZAPolicy >> description [
	^ description
]

{ #category : #accessing }
GtLZAPolicy >> description: anObject [
	description := anObject
]

{ #category : #testing }
GtLZAPolicy >> exists [
	^ self policy exists
]

{ #category : #views }
GtLZAPolicy >> gtPolicyFor: aView [
	<gtView>
	self exists ifFalse: [^ aView empty].

	^ aView forward
		title: 'Policy definition';
		priority: 1;
		object: [ self policy ];
		view: #gtJsonFor:
]

{ #category : #initialization }
GtLZAPolicy >> initialize [
	super initialize.
	organizationalUnitAssociations := FMNullMultivalueLink
			on: self
			opposite: #policy:
			selector: #organizationalUnitAssociations
]

{ #category : #accessing }
GtLZAPolicy >> organizationalUnitAssociations [
	<MSEProperty: #organizationalUnitAssociations type: #GtLZAOrganizationalUnitPolicyAssociation opposite: #policy>
	<multivalued>
	^ organizationalUnitAssociations
]

{ #category : #accessing }
GtLZAPolicy >> organizationalUnits [
	^ GtLZAOrganizationalUnitsGroup
		withAll: (organizationalUnitAssociations collect: [ :each | each organizationalUnit ])
]

{ #category : #accessing }
GtLZAPolicy >> policy [
	^ policy
]

{ #category : #accessing }
GtLZAPolicy >> policy: anObject [
	policy := anObject
]

{ #category : #accessing }
GtLZAPolicy >> type [
	^ type
]

{ #category : #accessing }
GtLZAPolicy >> type: anObject [
	type := anObject
]
