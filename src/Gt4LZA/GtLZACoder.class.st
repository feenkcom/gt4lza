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

{ #category : #private }
GtLZACoder >> buildSidebar [
	^ BrTabGroup new
		aptitude: BrGlamorousTabGroupAptitude;
		padding: (BlInsets all: 5);
		addTab: (BrTab new
				aptitude: BrGlamorousTabAptitude new;
				label: 'Files';
				stencil: [ self createFilesTree ])
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
	^ configurationFiles
		at: fileRef
		ifAbsentPut: [ GtLZAConfigurationFile new
				fileReference: fileRef;
				yourself ]
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
	file currentSource: aString.
	model updateFile: file asFileReference with: aString
]

{ #category : #accessing }
GtLZACoder >> file [
	^ file
]

{ #category : #accessing }
GtLZACoder >> file: anObject [
	self updateContentsTo: anObject
]

{ #category : #initialization }
GtLZACoder >> initialize [
	super initialize.
	configurationFiles := Dictionary new.
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
	(GtCompletionController
		on: textEditor
		strategy: ((GtLZAConfigCompletionStrategy forFileType: file fileReference basename)
				model: model)) install.
	textEditor
		addShortcut: (BlShortcutWithAction new
				combination: BlKeyCombination primaryS;
				action: [ aFile save ]).
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
								select: [ :dir | (dir allChildrenMatching: '*.yaml') notEmpty ].
						(OrderedCollection withAll: dirs)
							addAll: ((each childrenMatching: '*.yaml')
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
