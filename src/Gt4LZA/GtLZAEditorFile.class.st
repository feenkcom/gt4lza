Class {
	#name : #GtLZAEditorFile,
	#superclass : #GtLZAEditorEntity,
	#traits : 'TGtAnnouncer',
	#classTraits : 'TGtAnnouncer classTrait',
	#instVars : [
		'entities',
		'associations',
		'model',
		'fileReference',
		'announcer',
		'originalSource',
		'currentSource'
	],
	#category : #'Gt4LZA-Editor-Model'
}

{ #category : #adding }
GtLZAEditorFile >> addAssociation: anObject [
	self associations add: anObject.
	anObject file: self
]

{ #category : #adding }
GtLZAEditorFile >> addEntity: anObject [
	self entities add: anObject.
	anObject file: self
]

{ #category : #views }
GtLZAEditorFile >> addExpanderFor: association in: text [
	| to pos |
	to := association toEntity.
	pos := association node stopPosition.
	(text from: pos to: pos)
		attribute: (BrGlamorousTriangleExpanderTextAttribute new
				attributesCreatingBlock: [ BrTextAdornmentDynamicAttribute new
						beAppend;
						stencil: [ | pane view element |
							pane := BrVerticalPane new
									height: 300;
									aptitude: BrShadowAptitude
											+ (BrGlamorousWithVerticalResizerAptitude new
													beBottom;
													yourself);
									background: Color white;
									margin: (BlInsets all: 10);
									constraintsDo: [ :c | 
										c textFlow pushLine.
										c horizontal matchParent ].
							view := to gtSourceFor: GtPhlowView new.
							element := view asElement.
							element states addState: GtPhlowToolDetailState normal.
							pane
								addChild: (element
										constraintsDo: [ :c | 
											c horizontal matchParent.
											c vertical matchParent ]) ] ])
]

{ #category : #views }
GtLZAEditorFile >> addReferencesExpanderFor: anEntity in: text [
	anEntity hasName ifFalse: [ ^ self ].
	(anEntity node nodeForObject: anEntity name)
		ifNotNil: [ :n | 
			(text from: n stopPosition to: n stopPosition)
				attribute: (BrGlamorousTriangleExpanderTextAttribute new
						attributesCreatingBlock: [ BrTextAdornmentDynamicAttribute new
								beAppend;
								stencil: [ | pane view element |
									pane := BrVerticalPane new
											height: 200;
											aptitude: BrShadowAptitude
													+ (BrGlamorousWithVerticalResizerAptitude new
															beBottom;
															yourself);
											background: Color white;
											margin: (BlInsets all: 10);
											constraintsDo: [ :c | 
												c textFlow pushLine.
												c horizontal matchParent ].
									view := anEntity references gtReferencesView: GtPhlowView new.
									element := view asElement.
									element states addState: GtPhlowToolDetailState normal.
									pane
										addChild: (element
												constraintsDo: [ :c | 
													c horizontal matchParent.
													c vertical matchParent ]) ] ]) ]
]

{ #category : #announcer }
GtLZAEditorFile >> announcer [
	^ announcer ifNil: [ announcer := Announcer new ]
]

{ #category : #conversion }
GtLZAEditorFile >> asFileReference [
	^ self fileReference
]

{ #category : #accessing }
GtLZAEditorFile >> associations [
	^ associations ifNil: [ associations := OrderedCollection new ]
]

{ #category : #accessing }
GtLZAEditorFile >> associations: anObject [
	associations := anObject
]

{ #category : #accessing }
GtLZAEditorFile >> basename [
	^ fileReference basename
]

{ #category : #accessing }
GtLZAEditorFile >> cancel [
	self currentSource: self originalSource
]

{ #category : #testing }
GtLZAEditorFile >> containsReference: aFileReference [
	^ self fileReference containsReference: aFileReference
]

{ #category : #accessing }
GtLZAEditorFile >> currentSource [
	^ currentSource ifNil: [ currentSource := self originalSource ]
]

{ #category : #accessing }
GtLZAEditorFile >> currentSource: anObject [
	| original |
	currentSource = anObject ifTrue: [ ^ self ].
	original := currentSource.
	currentSource := anObject.
	self model updateFile: self asFileReference with: currentSource.
	self
		announce: (GtLZAFileSourceChanged new
				file: self;
				oldSource: original;
				yourself)
]

{ #category : #accessing }
GtLZAEditorFile >> entities [
	^ entities ifNil: [ entities := IdentitySet new ]
]

{ #category : #accessing }
GtLZAEditorFile >> entities: anObject [
	entities := anObject
]

{ #category : #accessing }
GtLZAEditorFile >> entityAtIndex: anInteger [
	entities
		do: [ :each | 
			each hasName
				ifTrue: [ (each node nodeForObject: each name)
						ifNotNil: [ :n | 
							| interval |
							interval := n sourceInterval.
							(anInteger between: interval first and: interval last) ifTrue: [ ^ each ] ] ] ].
	^ nil
]

{ #category : #accessing }
GtLZAEditorFile >> file [
	^ self
]

{ #category : #accessing }
GtLZAEditorFile >> fileReference [
	^ fileReference
]

{ #category : #accessing }
GtLZAEditorFile >> fileReference: anObject [
	fileReference := anObject
]

{ #category : #views }
GtLZAEditorFile >> findImplementerIn: textEditor [
	| index |
	textEditor editor cursors do: [ :each | index := each position ].
	index ifNil: [ ^ self ].
	self associations
		detect: [ :each | 
			| interval |
			interval := each node sourceInterval.
			index between: interval first and: interval last ]
		ifFound: [ :each | 
			each toEntity
				ifNotNil: [ :to | textEditor inUIProcessDo: [ textEditor phlow spawnObject: to ] ] ]
		ifNone: [  ]
]

{ #category : #views }
GtLZAEditorFile >> findReferencesIn: textEditor [
	| index references |
	textEditor editor cursors do: [ :each | index := each position ].
	index ifNil: [ ^ self ].
	(self entityAtIndex: index)
		ifNotNil: [ :entity | 
			references := entity references.
			textEditor inUIProcessDo: [ textEditor phlow spawnObject: references ] ]
]

{ #category : #views }
GtLZAEditorFile >> gtSourceFor: aView [
	<gtLzaView>
	^ aView explicit
		title: 'Source';
		priority: 10;
		stencil: [ | textEditor pane |
			textEditor := GtLZAConfigEditor new.
			textEditor matchParent.
			textEditor
				addAptitude: (BrGlamorousWithExplicitContextMenuAptitude
						menu: [ self menuItemsFor: textEditor ]).
			textEditor editor styler: self styler.
			(GtCompletionController
				on: textEditor
				strategy: ((GtLZAConfigCompletionStrategy forFileType: self fileReference basename)
						model: model)) install.
			textEditor
				addShortcut: (BlShortcutWithAction new
						combination: BlKeyCombination primaryS;
						action: [ self save ]);
				addShortcut: (BlShortcutWithAction new
						combination: BlKeyCombination primaryN;
						action: [ self findReferencesIn: textEditor ]);
				addShortcut: (BlShortcutWithAction new
						combination: BlKeyCombination primaryM;
						action: [ self findImplementerIn: textEditor ]).
			textEditor editor
				when: BrTextEditorInsertedEvent
					do: [ :event | self currentSource: event source text asString ];
				when: BrTextEditorDeletedEvent
					do: [ :event | self currentSource: event source text asString ];
				when: BlInfiniteDataSourceChanged
					do: [ :event | self currentSource: event source text asString ].
			self updateEditor: textEditor.
			self announcer
				when: GtLZAFileSourceChanged
				send: #value
				to: (WeakMessageSend
						receiver: self
						selector: #updateEditor:
						arguments: {textEditor}).
			textEditor
				enqueueTask: [ textEditor
						allParentsDetect: [ :each | each isKindOf: GtLZACoder ]
						ifFound: [ :each | 
							each highlightedEntity
								ifNotNil: [ :entity | 
									| source |
									source := textEditor text asString.
									textEditor editor text
										clearAttributes: [ :attr | attr class = BlTextHighlightAttribute ].
									(textEditor editor text
										from: entity node startPosition
										to: entity node stopPosition)
										attribute: (BlTextHighlightAttribute new
												beNotOverwritableByStyler;
												paint: BrGlamorousColors neutralBackgroundColor).
									textEditor
										scrollToPosition: (source lineNumberCorrespondingToIndex: entity node startPosition) ] ]
						ifNone: [  ] ] asBlTask.
			pane := BrVerticalPane new.
			pane matchParent.
			pane addChild: textEditor as: #configEditor.
			pane
				addAptitude: (BrGlamorousWithVerticalScrollbarAptitude new scrollableName: #configEditor).
			pane ]
]

{ #category : #testing }
GtLZAEditorFile >> isDirectory [
	^ false
]

{ #category : #testing }
GtLZAEditorFile >> isModified [
	^ currentSource notNil and: [ self originalSource ~= currentSource ]
]

{ #category : #actions }
GtLZAEditorFile >> load [
	originalSource := fileReference exists
				ifTrue: [ fileReference contents ]
				ifFalse: [ '' ].
	self currentSource: originalSource
]

{ #category : #views }
GtLZAEditorFile >> menuItemsFor: textEditor [
	| index menuItems  |
	menuItems := BrMenuItems new beGroupedElementType.
	self isModified
		ifTrue: [ menuItems
				addItem: (BrMenuActionItem new
						label: 'Save';
						action: [ self save ]);
				addItem: (BrMenuActionItem new
						label: 'Cancel';
						action: [ self cancel ]) ].
	textEditor editor cursors do: [ :each | index := each position ].
	index
		ifNotNil: [ (self entityAtIndex: index)
				ifNotNil: [ :entity | 
					menuItems
						addItem: (BrMenuActionItem new
								group: BrMenuItemGroupConfiguration navigation;
								label: 'Browse references';
								action: [ textEditor phlow spawnObject: entity references ]) ].
			self associations
				detect: [ :each | 
					| interval |
					interval := each node sourceInterval.
					index between: interval first and: interval last ]
				ifFound: [ :each | 
					each toEntity
						ifNotNil: [ :to | 
							menuItems
								addItem: (BrMenuActionItem new
										group: BrMenuItemGroupConfiguration navigation;
										label: 'Browse references';
										action: [ textEditor phlow spawnObject: to references ]);
								addItem: (BrMenuActionItem new
										group: BrMenuItemGroupConfiguration navigation;
										label: 'Browse definition';
										action: [ textEditor phlow spawnObject: to ]) ] ]
				ifNone: [  ] ].
	menuItems itemsCount = 0 ifTrue: [ ^ nil ].
	^ menuItems
]

{ #category : #accessing }
GtLZAEditorFile >> model [
	^ model
]

{ #category : #accessing }
GtLZAEditorFile >> model: anObject [
	model := anObject
]

{ #category : #accessing }
GtLZAEditorFile >> originalSource [
	^ originalSource
		ifNil: [ originalSource := fileReference exists
					ifTrue: [ fileReference contents ]
					ifFalse: [ '' ] ]
]

{ #category : #accessing }
GtLZAEditorFile >> originalSource: anObject [
	originalSource := anObject
]

{ #category : #actions }
GtLZAEditorFile >> resetModel [
	entities := nil.
	associations := nil
]

{ #category : #actions }
GtLZAEditorFile >> save [
	fileReference ensureDelete.
	fileReference writeStreamDo: [ :stream | stream nextPutAll: currentSource ].
	self originalSource: currentSource.
	self
		announce: (GtLZAFileSourceChanged new
				file: self;
				oldSource: nil;
				yourself)
]

{ #category : #accessing }
GtLZAEditorFile >> source [
	^ node completeSource asString
]

{ #category : #views }
GtLZAEditorFile >> styler [
	| rules |
	rules := {GtSmaCCNodeStylerRule
				nodeClassName: #SmaCCParseNode
				styleBlock: [ :styler :each :text | 
					each parent
						ifNil: [ | modelFile |
							modelFile := model fileEntityNamed: self asFileReference.
							modelFile entities
								do: [ :entity | self addReferencesExpanderFor: entity in: text ].
							modelFile associations
								do: [ :association | 
									association toEntity
										ifNil: [ (text from: association node startPosition to: association node stopPosition)
												highlight: BrGlamorousColors errorBackgroundColor ]
										ifNotNil: [ :entity | self addExpanderFor: association in: text ] ] ] ]}.
	rules do: [ :each | each continueOnMatch: true ].
	^ (GtCompositeSmaCCASTStyler forParser: YAMLParser)
		stylers: {YAMLParser gtStyler.
				(GtSmaCCParserStyler forParser: YAMLParser) stylerRules: rules}
]

{ #category : #views }
GtLZAEditorFile >> updateEditor: textEditor [
	textEditor editor text: self currentSource asRopedText
]
