Class {
	#name : #GtLZARouteTablesGroup,
	#superclass : #GtLZAGroup,
	#category : #'Gt4LZA-Model'
}

{ #category : #'as yet unclassified' }
GtLZARouteTablesGroup >> gtRouteTablesFor: aView [
	<gtView>
	^ aView columnedList
		title: 'Route tables';
		priority: 1;
		items: [ self items ];
		column: 'Name' text: #name;
		column: '# of routes' text: [ :aRouteTable | aRouteTable routes size ]
]

{ #category : #'as yet unclassified' }
GtLZARouteTablesGroup >> itemType [
	^ GtLZARouteTable
]
