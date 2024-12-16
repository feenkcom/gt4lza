Class {
	#name : #GtLZAEntitiesGroup,
	#superclass : #GtLZAGroup,
	#category : #'Gt4LZA-Model'
}

{ #category : #accessing }
GtLZAEntitiesGroup >> gtEntitiesFor: aView [
	<gtView>
	^ aView columnedList
		title: 'Entities';
		priority: 1;
		items: [ self items ];
		column: 'Name' text: #name
]

{ #category : #accessing }
GtLZAEntitiesGroup >> itemType [
	^ GtLZAEntity
]
