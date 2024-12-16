Class {
	#name : #GtLZAOrganizationalUnit,
	#superclass : #GtLZAEntity,
	#instVars : [
		'children'
	],
	#category : #'Gt4LZA-Model'
}

{ #category : #adding }
GtLZAOrganizationalUnit >> addChild: anEntity [
	children add: anEntity
]

{ #category : #accessing }
GtLZAOrganizationalUnit >> children [
	^ children
]

{ #category : #'gt-extension' }
GtLZAOrganizationalUnit >> gtChildrenFor: aView [
	<gtView>
	^ aView forward
		title: 'Children';
		priority: 1;
		object: [ children ];
		view: #gtEntitiesFor:
]

{ #category : #initialization }
GtLZAOrganizationalUnit >> initialize [
	super initialize.
	children := GtLZAEntitiesGroup new
]
