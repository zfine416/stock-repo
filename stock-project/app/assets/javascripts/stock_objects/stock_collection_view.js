var StockCollectionView = function(collection){
	this.collection = collection;
	$(this.collection).on('change', this.render.bind(this));
	var StockCollectionView = this;
	$('#new-stock-form').on('submit', function(e){
		e.preventDefault();
		console.log('1');
	debugger

		var stockData = this.elements;

		var newStockData = {
			ticker: stockData.ticker.value,
			name: stockData.name.value
		}
		StockCollectionView.collection.create(newStockData)
	})
}

StockCollectionView.prototype.$el = function(){
	return $('.stocks');
}

StockCollectionView.prototype.render = function(){
	this.$el.empty();
	this.collection.models.forEach(function(model){
		var newView = new StockView(model);
		this.$el().append(newView.render().$el);
	}.bind(this))
}