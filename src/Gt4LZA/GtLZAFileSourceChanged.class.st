Class {
	#name : #GtLZAFileSourceChanged,
	#superclass : #Announcement,
	#instVars : [
		'file',
		'oldSource'
	],
	#category : #'Gt4LZA-Editor'
}

{ #category : #accessing }
GtLZAFileSourceChanged >> file [
	^ file
]

{ #category : #accessing }
GtLZAFileSourceChanged >> file: anObject [
	file := anObject
]

{ #category : #accessing }
GtLZAFileSourceChanged >> oldSource [
	^ oldSource
]

{ #category : #accessing }
GtLZAFileSourceChanged >> oldSource: anObject [
	oldSource := anObject
]
