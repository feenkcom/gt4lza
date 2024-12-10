Class {
	#name : #GtLZAEntitiesGroup,
	#superclass : #GtLZAGroup,
	#category : #'Gt4LZA-Model'
}

{ #category : #'as yet unclassified' }
GtLZAEntitiesGroup >> gtEntitiesFor: aView [
	<gtView>
	^ aView columnedList
		title: 'Entities';
		priority: 1;
		items: [ self items ];
		column: 'Name' text: #name
]

{ #category : #'as yet unclassified' }
GtLZAEntitiesGroup >> itemType [
	^ GtLZAEntity
]
