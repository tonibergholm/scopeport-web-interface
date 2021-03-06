(function($) {
	var timeout = 10000;
	var timestamp = 0;
	check = function() {
		$.getJSON('/popup/getpopups', { 'timestamp': timestamp }, function(popups, textStatus) {
			$.each(popups, function(i, popup) {
				popup.after_close = function() {
					$.ajax({
						data: { id: popup.id },
						url: '/popup/closepopup'
					});
				};
				var id = $.gritter.add(popup)
				$('#alarm' + popup.id).bind('click', function (e) {
					$.gritter.remove(id);
				});
			});
		});
		timestamp = Math.round(new Date().getTime() / 1000);
		setTimeout(check, timeout);
	};
	check();
})(jQuery);
