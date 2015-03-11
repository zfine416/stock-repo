var StockCollection = function(){
	this.models = [];
}

StockCollection.prototype.add = function(stock){
	this.models.push(stock);

	$(this).trigger('change');
	$(stock).on('destroy', this.remove.bind(this, stock));
	$(stock).on('update', this.update.bind(this, stock));
}

StockCollection.prototype.create = function(stockData){
	var stockData = this;

	$.ajax({
		url: '/stocks',
		method: 'POST',
		dataType: 'json',
		data: {
			stock: stockData
		}
		success: function(data){
			stockCollection.add(data);
		}
	})
}

StockCollection.prototype.update = function(model,event,updateData){
	var stockCollection = this;

	$.ajax({
		url: '/stocks/' + model.id,
		method: "PATCH",
		data: {
			stock: updateData
		},
		success: function(data){
			model.ticker = data.ticker;
			model.name = data.name;
			$(stockCollection).trigger('change');
		}
	})
}

StockCollection.prototype.remove = function(model){
	var modelIndex = this.models.indexOf(model);
	var stockCollection = this;

	$.ajax({
		url:'/stocks/' + model.id,
		method: 'DELETE',
		dataType: 'json',
		success: function(data){
			stockCollection.models.splice(modelIndex, 1);
			$(stockCollection).trigger('change');
		}
	})
}

StockCollection.prototype.fetch = function(){
	var stockCollection = this;
	$.ajax({
		url: '/stocks',
		dataType: 'json',
		success: function(data){
			data.forEach(function(stock){
				var stockModel = new Stock(stock);
				stockCollection.add(stockModel);
			})
		}
	})
}
