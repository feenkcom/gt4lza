Class {
	#name : #GtLZARouteTable,
	#superclass : #GtLZAEntity,
	#instVars : [
		'routes',
		'parent'
	],
	#category : #'Gt4LZA-Model'
}

{ #category : #views }
GtLZARouteTable >> gtRoutesFor: aView [
	<gtView>
	routes ifNil: [ ^ aView empty ].
	^ aView columnedList
		title: 'Routes';
		priority: 1;
		items: [ routes ];
		column: 'Name' text: #name;
		column: 'Type' text: #type;
		column: 'Target' text: #target;
		column: 'Destination' text: #destination
]

{ #category : #accessing }
GtLZARouteTable >> parent [
	^ parent
]

{ #category : #accessing }
GtLZARouteTable >> parent: anObject [
	parent := anObject
]

{ #category : #accessing }
GtLZARouteTable >> routes [
	^ routes
]

{ #category : #accessing }
GtLZARouteTable >> routes: anObject [
	routes := anObject
]
