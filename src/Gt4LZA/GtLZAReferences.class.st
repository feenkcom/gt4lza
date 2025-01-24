Class {
	#name : #GtLZAReferences,
	#superclass : #Object,
	#instVars : [
		'references',
		'name'
	],
	#category : #'Gt4LZA-Editor-Model'
}

{ #category : #views }
GtLZAReferences >> asElement [
	^ BrVerticalPane new
		matchParent;
		padding: (BlInsets all: 10);
		addChild: (BrLabel new
				fitContent;
				aptitude: BrGlamorousLabelAptitude new bold;
				text: name , ' References');
		addChild: (BrSimpleList new
				matchParent;
				itemStencil: [ :each | 
					BrVerticalPane new
						vFitContent;
						hMatchParent;
						yourself ];
				itemDataBinder: [ :pane :each | 
					| expander |
					pane removeChildren.
					expander := BrExpander new
							hMatchParent;
							vFitContent;
							margin: (BlInsets all: 4);
							aptitude: (GtCoderExpanderAptitude new padding: BlInsets empty);
							beInSingleCompositionLayer;
							header: [ self collapsedElementFor: each ];
							content: [ self expandedElementFor: each ].
					expander
						when: BlClickEvent
						do: [ :anEvent | 
							expander isCollapsed
								ifTrue: [ anEvent consumed: true.
									expander expand ] ].
					pane addChild: expander ];
				stream: self references)
]

{ #category : #views }
GtLZAReferences >> collapsedElementFor: aReference [
	| fromEntity text clippedText |
	fromEntity := aReference fromEntity.
	text := fromEntity file currentSource asRopedText.
	YAMLParser gtStyler style: text.
	(text from: aReference node startPosition to: aReference node stopPosition)
		attribute: (BlTextDecorationAttribute new
				underline;
				color: BrGlamorousColors textHighlightColor;
				thickness: 3).
	clippedText := text clipForPreviewAround: aReference node startPosition.
	^ BrVerticalPane new
		vFitContent;
		hMatchParent;
		padding: (BlInsets all: 5);
		addChild: (self headerForEntity: fromEntity);
		addChild: (BrLabel new
				hMatchParent;
				vFitContent;
				aptitude: BrGlamorousLabelAptitude;
				text: clippedText);
		yourself
]

{ #category : #views }
GtLZAReferences >> expandedElementFor: aReference [
	| fromEntity |
	fromEntity := aReference fromEntity.
	^ BrVerticalPane new
		aptitude: BrGlamorousWithVerticalResizerAptitude;
		height: 300;
		hMatchParent;
		padding: (BlInsets all: 5);
		addChild: (self headerForEntity: fromEntity);
		addChild: (aReference coder
				vMatchParent;
				yourself);
		yourself
]

{ #category : #'gt - inspector' }
GtLZAReferences >> gtDefaultInspectorTool [
	^ GtPhlowCompositeTool new
		addTool: (GtPhlowExplicitTool new
				withLabelAndIconAptitude;
				name: 'References';
				icon: BrGlamorousVectorIcons browse;
				stencil: [ self asElement ]);
		addTool: super gtDefaultInspectorTool
]

{ #category : #views }
GtLZAReferences >> gtReferencesView: aView [
	<gtView>
	^ aView explicit
		title: 'References';
		stencil: [ self asElement ]
]

{ #category : #testing }
GtLZAReferences >> hasMultiple [
	| refs |
	refs := self references.
	^ (refs next await then: [ :a | refs hasNext wait ] otherwise: [ :a | false ])
		wait
]

{ #category : #views }
GtLZAReferences >> headerForEntity: fromEntity [
	| header |
	header := BrHorizontalPane new fitContent.
	header
		addChild: (BrLabel new
				fitContent;
				aptitude: (BrGlamorousLabelAptitude new thin padding: (BlInsets all: 0));
				text: fromEntity file name).
	(fromEntity file ~~ fromEntity and: [ fromEntity hasName ])
		ifTrue: [ header
				addChild: (BrLabel new
						aptitude: (BrGlamorousLabelAptitude new thin
								padding: (BlInsets all: 0);
								foreground: BrTheme default button defaultTextColor);
						text: '>');
				addChild: (BrLabel new
						fitContent;
						aptitude: (BrGlamorousLabelAptitude new thin padding: (BlInsets all: 0));
						text: fromEntity name) ].
	^ header
]

{ #category : #testing }
GtLZAReferences >> isEmpty [
	^ self references isNotEmpty wait not
]

{ #category : #accessing }
GtLZAReferences >> name [
	^ name
]

{ #category : #accessing }
GtLZAReferences >> name: anObject [
	name := anObject
]

{ #category : #accessing }
GtLZAReferences >> references [
	^ references asyncSimilarCopy
]

{ #category : #accessing }
GtLZAReferences >> references: asyncStream [
	references := asyncStream cached
]
