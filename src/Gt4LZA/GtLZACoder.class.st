Class {
	#name : #GtLZACoder,
	#superclass : #BrHorizontalPane,
	#instVars : [
		'model',
		'sidebarElement',
		'contentElement',
		'file',
		'configurationFiles',
		'modified'
	],
	#category : #'Gt4LZA-Editor'
}

{ #category : #styling }
GtLZACoder >> addExpanderFor: association in: text [
	| to pos |
	to := association toEntity.
	pos := association node stopPosition.
	(text from: pos to: pos)
		attribute: (BrGlamorousTriangleExpanderTextAttribute new
				attributesCreatingBlock: [ BrTextAdornmentDynamicAttribute new
						beAppend;
						stencil: [ | pane view |
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
							pane
								addChild: (view asElement
										constraintsDo: [ :c | 
											c horizontal matchParent.
											c vertical matchParent ]) ] ])
]

{ #category : #private }
GtLZACoder >> buildModelToolbar [
	| toolbar |
	toolbar := BrToolbar new
			aptitude: (BrGlamorousToolbarAptitude new spacing: 5);
			fitContent;
			margin: (BlInsets bottom: 5).
	toolbar
		addChild: (BrButton new
				aptitude: BrGlamorousButtonWithIconAptitude;
				beSmallSize;
				icon: BrGlamorousVectorIcons inspect;
				label: 'Inspect';
				action: [ :button | 
					button phlow
						spawnObject: (GtLZAImporter new
								directory: model directory;
								import) ])
		as: #inspectAction.
	^ toolbar
]

{ #category : #private }
GtLZACoder >> buildSidebar [
	^ BrTabGroup new
		aptitude: BrGlamorousTabGroupAptitude;
		padding: (BlInsets all: 5);
		addTab: (BrTab new
				aptitude: BrGlamorousTabAptitude new;
				label: 'Files';
				stencil: [ self createFilesTree ]);
		actionbarStencil: [ BrToolbar new
				aptitude: BrGlamorousToolbarAptitude new;
				addItem: self searchButton;
				yourself ]
]

{ #category : #private }
GtLZACoder >> buildToolbarFor: aFile [
	| toolbar |
	toolbar := BrToolbar new
			aptitude: (BrGlamorousToolbarAptitude new spacing: 5);
			fitContent;
			margin: (BlInsets bottom: 5).
	toolbar
		addChild: (BrButton new
				aptitude: BrGlamorousButtonWithIconAptitude;
				beSmallSize;
				icon: BrGlamorousVectorIcons accept;
				label: 'Save';
				action: [ aFile save ])
		as: #saveAction.
	toolbar
		addChild: (BrButton new
				aptitude: BrGlamorousButtonWithIconAptitude;
				beSmallSize;
				icon: BrGlamorousVectorIcons cancel;
				label: 'Cancel';
				action: [ aFile cancel ])
		as: #cancelAction.
	^ toolbar
]

{ #category : #private }
GtLZACoder >> configurationFileFor: fileRef [
	^ model fileEntityNamed: fileRef
]

{ #category : #private }
GtLZACoder >> createFilesTree [
	| tree |
	tree := BrSimpleTree new
			matchParent;
			rowStencil: BrGlamorousSimpleTreeSelectableRowElementStencilBuilder new;
			nodeStencil: [ BrHorizontalPane new
					hMatchParent;
					vFitContent;
					addChild: (BrLabel new
								aptitude: BrGlamorousLabelAptitude;
								fitContent;
								yourself)
						as: #label;
					addChild: (BrButton new
								background: self theme status changesBackgroundColor;
								size: 8 @ 8;
								geometry: BlEllipseGeometry new;
								margin: (BlInsets
										top: 6
										bottom: 0
										left: 2
										right: 2);
								visibility: BlVisibility gone;
								yourself)
						as: #button ];
			nodeDataBinder: [ :element :each | 
				each isDirectory ifFalse: [ element userData at: #file put: each ].
				self updateModifiedIn: element.
				(element childNamed: #label) text: each basename ];
			when: BlElementAddedToSceneGraphEvent do: [ :event | self updateTrees ];
			yourself.
	self updateFileTreeItems: tree.
	file
		ifNotNil: [ tree expandSuchThat: [ :each | file fileReference isContainedBy: each value ].
			tree selectAndScrollTo: file.
			self updateContentsTo: file ].
	tree
		when: BrSelectionChanged
		do: [ :event | 
			tree
				selectedNodeDo: [ :aNode | 
					aNode value
						ifNotNil: [ :sel | 
							self file: aNode value.
							self updateContentsTo: file ] ] ].
	tree id: #files.
	^ tree
]

{ #category : #private }
GtLZACoder >> editorChangedTo: aString [
	file currentSource: aString
]

{ #category : #accessing }
GtLZACoder >> file [
	^ file
]

{ #category : #accessing }
GtLZACoder >> file: anObject [
	self updateContentsTo: anObject
]

{ #category : #private }
GtLZACoder >> findImplementerIn: textEditor [
	| index |
	file ifNil: [ ^ self ].
	textEditor editor cursors do: [ :each | index := each position ].
	index ifNil: [ ^ self ].
	file associations
		detect: [ :each | 
			| interval |
			interval := each node sourceInterval.
			index between: interval first and: interval last ]
		ifFound: [ :each | 
			each toEntity
				ifNotNil: [ :to | textEditor inUIProcessDo: [ textEditor phlow spawnObject: to ] ] ]
		ifNone: [  ]
]

{ #category : #private }
GtLZACoder >> findReferencesIn: textEditor [
	| index references |
	file ifNil: [ ^ self ].
	textEditor editor cursors do: [ :each | index := each position ].
	index ifNil: [ ^ self ].
	(file entityAtIndex: index)
		ifNotNil: [ :entity | 
			references := entity references.
			textEditor inUIProcessDo: [ textEditor phlow spawnObject: references ] ]
]

{ #category : #accessing }
GtLZACoder >> highlight: aNode [
	self
		enqueueTask: [ self
				inUIProcessDo: [ contentElement
						childNamed: #editor
						ifFound: [ :editor | 
							| source |
							source := editor text asString.
							editor editor text
								clearAttributes: [ :each | each class = BlTextHighlightAttribute ].
							(editor editor text from: aNode startPosition to: aNode stopPosition)
								attribute: (BlTextHighlightAttribute new
										beNotOverwritableByStyler;
										paint: BrGlamorousColors neutralBackgroundColor).
							editor
								scrollToPosition: (source lineNumberCorrespondingToIndex: aNode startPosition) ] ] ]
				asBlTask
]

{ #category : #initialization }
GtLZACoder >> initialize [
	super initialize.
	self matchParent.
	self initializeSidebar.
	self initializeContent.
	self addChild: sidebarElement as: #sidebar.
	self addChild: contentElement as: #content
]

{ #category : #initialization }
GtLZACoder >> initializeContent [
	contentElement := BrHorizontalPane new
			margin: (BlInsets all: 5);
			matchParent
]

{ #category : #initialization }
GtLZACoder >> initializeSidebar [
	sidebarElement := GtPhlowHorizontalSidebarElement new
			beLeft;
			matchParent;
			background: BrGlamorousColors neutralBackgroundColor.
	self
		addAptitude: (GtPhlowToolDetailAptitude new
				normal: [ :aStyle | aStyle do: [ sidebarElement hide ] ];
				detailed: [ :aStyle | aStyle do: [ sidebarElement show ] ]).
	sidebarElement hide
]

{ #category : #accessing }
GtLZACoder >> model [
	^ model
]

{ #category : #accessing }
GtLZACoder >> model: anObject [
	model := anObject.
	self modelUpdated
]

{ #category : #private }
GtLZACoder >> modelUpdated [
	| yamlFile |
	yamlFile := model directory / 'organization-config.yaml'.
	yamlFile exists
		ifFalse: [ yamlFile := (model directory childrenMatching: '*.yaml') at: 1 ifAbsent: [  ] ].
	self file: (self configurationFileFor: yamlFile absolutePath asFileReference).
	sidebarElement contentStencil: [ self buildSidebar ]
]

{ #category : #private }
GtLZACoder >> modificationColor [
	^ file isModified
		ifTrue: [ self theme status changesBackgroundColor ]
		ifFalse: [ Color transparent ]
]

{ #category : #private }
GtLZACoder >> searchButton [
	^ (GtSpotterDropdownButtonStencil new
		valuable: [ model ];
		tooltip: 'Search';
		icon: BrGlamorousVectorIcons search;
		objectActOn: [ :anActOnEvent :anItem | 
			anActOnEvent beActed.
			self file: anItem file.
			self updateFiles.
			self highlight: anItem node ]) asElement
]

{ #category : #styling }
GtLZACoder >> stylerFor: aFile [
	| rules |
	rules := {GtSmaCCNodeStylerRule
				nodeClassName: #SmaCCParseNode
				styleBlock: [ :styler :node :text | 
					node parent
						ifNil: [ (model fileEntityNamed: aFile asFileReference) associations
								do: [ :each | 
									each toEntity
										ifNil: [ (text from: each node startPosition to: each node stopPosition)
												highlight: BrGlamorousColors errorBackgroundColor ]
										ifNotNil: [ :entity | self addExpanderFor: each in: text ] ] ] ]}.
	rules do: [ :each | each continueOnMatch: true ].
	^ (GtCompositeSmaCCASTStyler forParser: YAMLParser)
		stylers: {YAMLParser gtStyler.
				(GtSmaCCParserStyler forParser: YAMLParser) stylerRules: rules}
]

{ #category : #private }
GtLZACoder >> updateChangeStatus: anEvent [
	modified = anEvent file isModified ifTrue: [ ^ self ].
	modified := anEvent file isModified.
	contentElement
		childNamed: #modificationBar
		ifFound: [ :elmt | elmt inUIProcessDo: [ elmt background: self modificationColor ] ].
	contentElement
		childNamed: #saveAction
		ifFound: [ :elmt | elmt inUIProcessDo: [ elmt enabled: file isModified ] ].
	contentElement
		childNamed: #cancelAction
		ifFound: [ :elmt | elmt inUIProcessDo: [ elmt enabled: file isModified ] ].
	sidebarElement
		childNamed: #files
		ifFound: [ :files | 
			files
				allChildrenBreadthFirstDetect: [ :each | (each userData at: #file ifAbsent: [  ]) = anEvent file ]
				ifFound: [ :elmt | self updateModifiedIn: elmt ] ].
	anEvent file = file
		ifTrue: [ contentElement
				childNamed: #editor
				ifFound: [ :elmt | 
					elmt editor text asString = file currentSource
						ifFalse: [ self updateEditorText: elmt ] ] ]
]

{ #category : #private }
GtLZACoder >> updateContentsTo: aFile [
	| textEditor content titleContent fileToolbar |
	(aFile notNil and: [ aFile = file or: [ aFile isDirectory ] ])
		ifTrue: [ ^ self ].
	file := aFile.
	file announcer weak
		when: GtLZAFileSourceChanged
		send: #updateChangeStatus:
		to: self.
	contentElement removeChildren.
	contentElement
		addChild: (BlElement new
				width: 5;
				constraintsDo: [ :c | c vertical matchParent ];
				yourself)
		as: #modificationBar.
	textEditor := GtLZAConfigEditor new.
	textEditor editor styler: (self stylerFor: file).
	(GtCompletionController
		on: textEditor
		strategy: ((GtLZAConfigCompletionStrategy forFileType: file fileReference basename)
				model: model)) install.
	textEditor
		addShortcut: (BlShortcutWithAction new
				combination: BlKeyCombination primaryS;
				action: [ aFile save ]);
		addShortcut: (BlShortcutWithAction new
				combination: BlKeyCombination primaryN;
				action: [ self findReferencesIn: textEditor ]);
		addShortcut: (BlShortcutWithAction new
				combination: BlKeyCombination primaryM;
				action: [ self findImplementerIn: textEditor ]).
	textEditor editor
		when: BrTextEditorInsertedEvent
			do: [ :event | self editorChangedTo: event source text asString ];
		when: BrTextEditorDeletedEvent
			do: [ :event | self editorChangedTo: event source text asString ];
		when: BlInfiniteDataSourceChanged
			do: [ :event | self editorChangedTo: event source text asString ].
	self updateEditorText: textEditor.
	content := BrVerticalPane new.
	content matchParent.
	titleContent := BrHorizontalPane new.
	titleContent hMatchParent.
	titleContent vFitContent.
	titleContent
		addChild: (BrVerticalPane new
				fitContent;
				addChild: (BrLabel new
							aptitude: (BrGlamorousLabelAptitude new glamorousRegularFontAndSize
									foreground: Color gray;
									fontSize: 12);
							text: 'File';
							yourself)
					as: #label;
				addChild: (BrLabel new
							aptitude: (BrGlamorousLabelAptitude new
									bold;
									fontSize: 18);
							text: aFile fileReference basename)
					as: #filename;
				yourself);
		addChild: (self buildModelToolbar
				padding: (BlInsets top: 5 right: 5);
				constraintsDo: [ :c | 
					c ignoreByLayout.
					c ignored horizontal alignRight.
					c ignored vertical alignTop ];
				yourself).
	content addChild: titleContent.
	content addChild: textEditor as: #editor.
	content
		addAptitude: (BrGlamorousWithVerticalScrollbarAptitude new scrollableName: #editor).
	fileToolbar := self buildToolbarFor: file.
	content addChild: fileToolbar as: #toolbar.
	contentElement addChild: content.
	self updateChangeStatus: (GtLZAFileSourceChanged new file: file)
]

{ #category : #private }
GtLZACoder >> updateEditorText: textEditor [
	textEditor editor text: file currentSource asRopedText
]

{ #category : #private }
GtLZACoder >> updateFileTreeItems: tree [
	tree
		items: {model directory absolutePath asFileReference}
			lazy: [ :each | 
				each isDirectory
					ifTrue: [ | dirs |
						dirs := each directories
								select: [ :dir | 
									(dir allChildrenMatching: '*.yaml') notEmpty
										or: [ (dir allChildrenMatching: '*.json') notEmpty ] ].
						(OrderedCollection withAll: dirs)
							addAll: ((each childrenMatching: '*.yaml;*.json')
									collect: [ :fileRef | self configurationFileFor: fileRef ]);
							sort: [ :a :b | a basename < b basename ];
							yourself ]
					ifFalse: [ #() ] ];
		expandOneLevel
]

{ #category : #private }
GtLZACoder >> updateFiles [
	file ifNil: [ ^ self ].
	self
		childNamed: #files
		ifFound: [ :tree | 
			tree expandSuchThat: [ :each | file asFileReference isContainedBy: each value ].
			tree selectAndScrollTo: file ]
]

{ #category : #private }
GtLZACoder >> updateModifiedIn: anElement [
	(anElement childNamed: #button)
		visibility: (((anElement userData at: #file ifAbsent: [  ])
				ifNil: [ false ]
				ifNotNil: [ :f | f isModified ])
				ifTrue: [ BlVisibility visible ]
				ifFalse: [ BlVisibility gone ])
]

{ #category : #private }
GtLZACoder >> updateTrees [
	self
		inUIProcessDo: [ self
				childNamed: #files
				ifFound: [ :tree | 
					self updateFileTreeItems: tree.
					self updateFiles ] ]
]
