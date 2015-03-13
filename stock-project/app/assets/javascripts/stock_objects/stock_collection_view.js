// var StockCollectionView = function(collection){
// 	this.collection = collection;
// 	$(this.collection).on('change', this.render.bind(this));
// 	var stockCollectionView = this;
// 	$('#new-stock-form').on('submit', function(e){
// 		e.preventDefault();
// 	debugger

// 		var stockData = this.elements;

// 		var newStockData = {
// 			ticker: stockData.ticker.value,
// 			name: stockData.name.value
// 		}
// 		stockCollectionView.collection.create(newStockData)
// 	})
// }

// StockCollectionView.prototype.$el = function(){
// 	return $('.stocks');
// }

// StockCollectionView.prototype.render = function(){
// 	var $list = $('.stocks') 
// 	this.$el.empty();
// 	this.collection.models.forEach(function(model){
// 		var newView = new StockView(model);
// 		this.$list().append(newView.render());
// 	}.bind(this))
// }