$('body').on('click', '.favorite', function(){
	$(this).css('background-color', 'yellow');
});

// var StockView = function(model){
// 	this.model = model;
// 	this.$el = $('<li></li>');
// }

// StockView.prototype.render = function(){
// 	var StockView = this;
// 	this.$el.html(this.template());
// 	this.$el.on('click', '.delete', function(e){
// 		$(StockView.model).trigger('destroy');
// 	})
// 	this.$el.on('submit', '.edit-stock-form',
// 		function(e){
// 			e.preventDefault();

// 			var stockData = this.elements;

// 			var updatedStockData = {
// 				ticker: stockData.ticker.value,
// 				name: stockData.name.value
// 			}
// 			$(StockView.model).trigger('update', updatedStockData)
// 		})
// 	return this;
// }

// StockView.prototype.template = function(){
// 	var compiledTemplate = Handlebars.templates['stock-view-template'];
// 	return compiledTemplate(this.model);
// }