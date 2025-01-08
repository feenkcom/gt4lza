Class {
	#name : #GtLZAConfigurationFile,
	#superclass : #Object,
	#traits : 'TGtAnnouncer',
	#classTraits : 'TGtAnnouncer classTrait',
	#instVars : [
		'originalSource',
		'currentSource',
		'fileReference',
		'announcer'
	],
	#category : #'Gt4LZA-Editor'
}

{ #category : #announcer }
GtLZAConfigurationFile >> announcer [
	^ announcer ifNil: [ announcer := Announcer new ]
]

{ #category : #converting }
GtLZAConfigurationFile >> asFileReference [
	^ self fileReference
]

{ #category : #accessing }
GtLZAConfigurationFile >> basename [
	^ fileReference basename
]

{ #category : #actions }
GtLZAConfigurationFile >> cancel [
	self currentSource: originalSource
]

{ #category : #testing }
GtLZAConfigurationFile >> containsReference: aFileReference [
	^ self fileReference containsReference: aFileReference
]

{ #category : #accessing }
GtLZAConfigurationFile >> currentSource [
	^ currentSource ifNil: [ currentSource := self originalSource ]
]

{ #category : #accessing }
GtLZAConfigurationFile >> currentSource: anObject [
	| original |
	currentSource = anObject ifTrue: [ ^ self ].
	original := currentSource.
	currentSource := anObject.
	self
		announce: (GtLZAFileSourceChanged new
				file: self;
				oldSource: original;
				yourself)
]

{ #category : #accessing }
GtLZAConfigurationFile >> fileReference [
	^ fileReference
]

{ #category : #accessing }
GtLZAConfigurationFile >> fileReference: anObject [
	fileReference := anObject
]

{ #category : #testing }
GtLZAConfigurationFile >> isDirectory [
	^ false
]

{ #category : #testing }
GtLZAConfigurationFile >> isModified [
	^ currentSource notNil and: [ originalSource ~= currentSource ]
]

{ #category : #actions }
GtLZAConfigurationFile >> load [
	currentSource := originalSource := fileReference exists
				ifTrue: [ fileReference contents ]
				ifFalse: [ '' ]
]

{ #category : #accessing }
GtLZAConfigurationFile >> originalSource [
	^ originalSource
		ifNil: [ originalSource := fileReference exists
					ifTrue: [ fileReference contents ]
					ifFalse: [ '' ] ]
]

{ #category : #accessing }
GtLZAConfigurationFile >> originalSource: anObject [
	originalSource := anObject
]

{ #category : #actions }
GtLZAConfigurationFile >> save [
	fileReference ensureDelete.
	fileReference writeStreamDo: [ :stream | stream nextPutAll: currentSource ].
	self originalSource: currentSource.
	self
		announce: (GtLZAFileSourceChanged new
				file: self;
				oldSource: nil;
				yourself)
]
