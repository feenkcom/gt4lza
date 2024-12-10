Class {
	#name : #GtLZARouteTable,
	#superclass : #GtLZAEntity,
	#instVars : [
		'routes',
		'parent'
	],
	#category : #'Gt4LZA-Model'
}

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
