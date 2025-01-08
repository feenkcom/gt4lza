Class {
	#name : #GtLZAConfigEditor,
	#superclass : #BrEditor,
	#category : #'Gt4LZA-Editor'
}

{ #category : #'instace creation' }
GtLZAConfigEditor class >> onAccountsFile: aFilename [
	| editor source strategy |
	source := aFilename asFileReference contents asRopedText.
	editor := self new.
	editor editor text: source.
	strategy := GtLZAConfigCompletionStrategy forAccountsConfig.
	(GtCompletionController on: editor strategy: strategy) install.
	^ editor
]

{ #category : #'instace creation' }
GtLZAConfigEditor class >> onNetworkFile: aFilename [
	| editor source strategy |
	source := aFilename asFileReference contents asRopedText.
	editor := self new.
	editor editor text: source.
	strategy := GtLZAConfigCompletionStrategy forNetworkConfig.
	(GtCompletionController on: editor strategy: strategy) install.
	^ editor
]

{ #category : #'instace creation' }
GtLZAConfigEditor class >> onOrganizationalFile: aFilename [
	| editor source strategy |
	source := aFilename asFileReference contents asRopedText.
	editor := self new.
	editor editor text: source.
	strategy := GtLZAConfigCompletionStrategy forOrganizationConfig.
	(GtCompletionController on: editor strategy: strategy) install.
	^ editor
]

{ #category : #initialization }
GtLZAConfigEditor >> initialize [
	super initialize.
	self aptitude: BrGlamorousCodeEditorAptitude.
	self editor styler: YAMLParser gtStyler
]
