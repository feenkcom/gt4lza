Class {
	#name : #GtLZAOrganizationalUnit,
	#superclass : #GtLZAEntity,
	#instVars : [
		'children',
		'accountAssociations'
	],
	#category : #'Gt4LZA-Model'
}

{ #category : #'as yet unclassified' }
GtLZAOrganizationalUnit >> accountAssociations [
	<MSEProperty: #accountAssociations type: #GtLZAAccountOrganizationalUnitAssociation opposite: #organizationalUnit>
	<multivalued>
	^ accountAssociations
]

{ #category : #adding }
GtLZAOrganizationalUnit >> addChild: anEntity [
	children add: anEntity
]

{ #category : #accessing }
GtLZAOrganizationalUnit >> children [
	^ GtLZAEntitiesGroup new
		addAll: children;
		addAll: (accountAssociations collect: #account);
		yourself
]

{ #category : #'gt-extension' }
GtLZAOrganizationalUnit >> gtChildrenFor: aView [
	<gtView>
	^ aView forward
		title: 'Children';
		priority: 1;
		object: [ self children ];
		view: #gtEntitiesFor:
]

{ #category : #initialization }
GtLZAOrganizationalUnit >> initialize [
	super initialize.
	children := GtLZAEntitiesGroup new.
	accountAssociations := FMNullMultivalueLink
			on: self
			opposite: #organizationalUnit:
			selector: #accountAssociations
]
