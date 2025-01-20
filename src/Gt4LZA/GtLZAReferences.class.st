Class {
	#name : #GtLZAReferences,
	#superclass : #Object,
	#instVars : [
		'references',
		'name'
	],
	#category : #'Gt4LZA-Editor-Model'
}

{ #category : #'as yet unclassified' }
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
				addEventHandler: GtPhlowListToSelectHandler new;
				itemStencil: [ :each | 
					BrVerticalPane new
						aptitude: BrGlamorousListItemAptitude;
						vFitContent;
						hMatchParent;
						padding: (BlInsets all: 5);
						addChild: (BrHorizontalPane new
									fitContent;
									addChild: (BrLabel new
												fitContent;
												aptitude: (BrGlamorousLabelAptitude new thin padding: (BlInsets all: 0)))
										as: #file;
									addChild: (BrLabel new
												aptitude: (BrGlamorousLabelAptitude new thin
														padding: (BlInsets all: 0);
														foreground: BrTheme default button defaultTextColor);
												text: '>')
										as: #gt;
									addChild: (BrLabel new
												fitContent;
												aptitude: (BrGlamorousLabelAptitude new thin padding: (BlInsets all: 0)))
										as: #entityName;
									yourself)
							as: #header;
						addChild: (BrLabel new
									hMatchParent;
									vFitContent;
									aptitude: BrGlamorousLabelAptitude;
									text: '' asRopedText)
							as: #content;
						yourself ];
				itemDataBinder: [ :pane :each | 
					| fromEntity visibility |
					fromEntity := each fromEntity.
					pane
						childNamed: #file
						ifFound: [ :label | label text: fromEntity file name ].
					visibility := (fromEntity file ~~ fromEntity and: [ fromEntity hasName ])
							ifTrue: [ BlVisibility visible ]
							ifFalse: [ BlVisibility gone ].
					pane childNamed: #gt ifFound: [ :label | label visibility: visibility ].
					pane
						childNamed: #entityName
						ifFound: [ :label | 
							label visibility: visibility.
							label text: fromEntity name ].
					pane
						childNamed: #content
						ifFound: [ :label | 
							| text |
							text := fromEntity file currentSource asRopedText.
							YAMLParser gtStyler style: text.
							(text from: each node startPosition to: each node stopPosition)
								attribute: (BlTextDecorationAttribute new
										underline;
										color: BrGlamorousColors textHighlightColor;
										thickness: 3).
							label text: (text clipForPreviewAround: each node startPosition) ].
					pane ];
				stream: self references)
]

{ #category : #'as yet unclassified' }
GtLZAReferences >> gtDefaultInspectorTool [
	^ GtPhlowCompositeTool new
		addTool: (GtPhlowExplicitTool new
				withLabelAndIconAptitude;
				name: 'References';
				icon: BrGlamorousVectorIcons browse;
				stencil: [ self asElement ]);
		addTool: super gtDefaultInspectorTool
]

{ #category : #'as yet unclassified' }
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
