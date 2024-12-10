Class {
	#name : #GtLZAOrganizationalUnit,
	#superclass : #GtLZAEntity,
	#instVars : [
		'children'
	],
	#category : #'Gt4LZA-Model'
}

{ #category : #'as yet unclassified' }
GtLZAOrganizationalUnit >> addChild: anEntity [
	children add: anEntity
]

{ #category : #'as yet unclassified' }
GtLZAOrganizationalUnit >> children [
	^ children
]

{ #category : #'as yet unclassified' }
GtLZAOrganizationalUnit >> gtChildrenFor: aView [
	<gtView>
	^ aView forward
		title: 'Children';
		priority: 1;
		object: [ children ];
		view: #gtEntitiesFor:
]

{ #category : #'as yet unclassified' }
GtLZAOrganizationalUnit >> initialize [
	children := GtLZAEntitiesGroup new
]
