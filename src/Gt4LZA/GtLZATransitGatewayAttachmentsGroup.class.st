Class {
	#name : #GtLZATransitGatewayAttachmentsGroup,
	#superclass : #GtLZAGroup,
	#category : #'Gt4LZA-Model'
}

{ #category : #'as yet unclassified' }
GtLZATransitGatewayAttachmentsGroup >> gtTransitGatewayAttachmentsFor: aView [
	<gtView>
	^ aView columnedList
		title: 'Transit gateway attachments';
		priority: 1;
		items: [ self items ];
		column: 'Name' text: #name;
		column: 'Gateway' text: #transitGateway;
		column: 'RT associations'
			text: [ :anAttachment | anAttachment routeTableAssociations size ] width: 100;
		column: 'RT propagations'
			text: [ :anAttachment | anAttachment routeTablePropagations size ] width: 100;
		column: 'Subnets' text: [ :anAttachment | anAttachment subnets size ] width: 100
]
