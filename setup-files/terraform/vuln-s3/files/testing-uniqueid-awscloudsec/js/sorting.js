$(window).load(function(){
	
	var $container = $('.portfolio_block, .shop_block');

	$container.isotope({
		itemSelector : '.element',
		masonry: {columnWidth: 1}
	});
    
	var $optionSets = $('#options .option-set'),
		$optionLinks = $optionSets.find('a');

	$optionLinks.click(function(){
		var $this = $(this);
		// don't proceed if already selected
		if ( $this.hasClass('selected') ) {
			return false;
		}
		var $optionSet = $this.parents('.option-set');
		$optionSet.find('.selected').removeClass('selected');
		$this.addClass('selected');

		// make option object dynamically, i.e. { filter: '.my-filter-class' }
		var options = {},
			key = $optionSet.attr('data-option-key'),
			value = $this.attr('data-option-value');
		// parse 'false' as false boolean
		value = value === 'false' ? false : value;
		options[ key ] = value;
		if ( key === 'layoutMode' && typeof changeLayoutMode === 'function' ) {
			// changes in layout modes need extra logic
			changeLayoutMode( $this, options )
		} else {
			// otherwise, apply new options
			$container.isotope( options );
		}
	
		return false;
	});
	
	// toggle variable sizes of all elements
	$('#toggle-sizes').find('a.view_full').click(function(){
		$('.shop_block')
			.addClass('variable-sizes')
			.isotope('reLayout');
		return false;
	});
	$('#toggle-sizes').find('a.view_box').click(function(){
		$('.shop_block')
			.removeClass('variable-sizes')
			.isotope('reLayout');
		return false;
	});
	
	//Load More for Portfolio
	jQuery.fn.portfolio_addon = function(addon_options) {
		//Set Variables
		var addon_el = jQuery(this),
			addon_base = this,
			img_count = addon_options.items.length,
			img_per_load = addon_options.load_count,
			$newEls = '',
			loaded_object = '',
			$container = jQuery('.portfolio_block');
		
		jQuery('.btn_load_more').click(function(){
			/*$('html,body').animate({scrollTop: $(this).offset().top-0}, 'slow');*/
			$newEls = '';
			loaded_object = '';									   
			loaded_images = $container.find('.added').size();
			if ((img_count - loaded_images) > img_per_load) {
				now_load = img_per_load;
			} else {
				now_load = img_count - loaded_images;
			}
			
			if ((loaded_images + now_load) == img_count) jQuery(this).fadeOut();

			if (loaded_images < 1) {
				i_start = 1;
			} else {
				i_start = loaded_images+1;
			}

			if (now_load > 0) {
				if (addon_options.type == 0) {
					//1 Column Service Type
					for (i = i_start-1; i < i_start+now_load-1; i++) {
						loaded_object = loaded_object + '<div class="element '+ addon_options.items[i].category +' project added"><div class="col-lg-6 col-sm-6 padbot20"><div class="hover_img"><img src="'+ addon_options.items[i].src +'" alt="" /><a class="zoom" href="'+ addon_options.items[i].src +'" rel="prettyPhoto[portfolio1]"></a></div></div><div class="col-lg-6 col-sm-6 padbot20"><h4><a href="'+ addon_options.items[i].url +'" alt="">Praesent a porta eros</a></h4><p>'+ addon_options.items[i].content +' <a href="'+ addon_options.items[i].url +'" class="more_link">Read more...</a></p></div><div class="clear"></div></div>';
					}
				} else {
					//2-4 Columns Portfolio Type
					for (i = i_start-1; i < i_start+now_load-1; i++) {
						loaded_object = loaded_object + '<div class="element col-sm-4  gall '+ addon_options.items[i].category +'"><a class="plS" href="'+ addon_options.items[i].src +'" rel="prettyPhoto[gallery2]"><img class="img-responsive picsGall" src="'+ addon_options.items[i].src +'" alt="pic2 Gallery"/></a><div class="view project_descr "><h3><a href="#">'+ addon_options.items[i].title +'</a></h3><ul><li><i class="fa fa-eye"></i>'+ addon_options.items[i].view_count +'</li><li><a  class="heart" href="#"><i class="fa-heart-o"></i>'+ addon_options.items[i].lika_count +'</a></li></ul></div></div>';
					}
				}
				
				$newEls = jQuery(loaded_object);
				$container.isotope('insert', $newEls, function() {
					$container.isotope('reLayout');
					
					jQuery("a[rel^='prettyPhoto']").prettyPhoto();
					
				});
			}
		});
	}	

});




