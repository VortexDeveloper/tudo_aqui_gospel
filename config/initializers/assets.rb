# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = '1.0'

# Add additional assets to the asset load path
# Rails.application.config.assets.paths << Emoji.images_path

# Precompile additional assets.
# application.js, application.css, and all non-JS/CSS in app/assets folder are already added.
# Rails.application.config.assets.precompile += %w( search.js )

#CSS
Rails.application.config.assets.precompile += %w( bootstrap.css )
Rails.application.config.assets.precompile += %w( bootstrap-tagsinput.css )
Rails.application.config.assets.precompile += %w( jasny-bootstrap.min.css )
#Rails.application.config.assets.precompile += %w( fonts/font-awesome-4.2.0/css/font-awesome.css )
Rails.application.config.assets.precompile += %w( effect2.css )
Rails.application.config.assets.precompile += %w( animate.css )
Rails.application.config.assets.precompile += %w( fancybox/jquery.fancybox.css )
Rails.application.config.assets.precompile += %w( owl.carousel.css )
Rails.application.config.assets.precompile += %w( owl.theme.css )
Rails.application.config.assets.precompile += %w( owl.transitions.css )
Rails.application.config.assets.precompile += %w( rs-wp-v1.2.css )
Rails.application.config.assets.precompile += %w( jquery.rs.selectbox.css )
Rails.application.config.assets.precompile += %w( style.css )
Rails.application.config.assets.precompile += %w( responsive.css )
Rails.application.config.assets.precompile += %w( ckeditor/* )


#SCRIPTS
Rails.application.config.assets.precompile += %w( jquery.1.11.1.js )
Rails.application.config.assets.precompile += %w( jquery_ujs.js )
Rails.application.config.assets.precompile += %w( bootstrap.min.js )
Rails.application.config.assets.precompile += %w( bootstrap-tagsinput.js )
Rails.application.config.assets.precompile += %w( jqBootstrapValidation.js )
Rails.application.config.assets.precompile += %w( wow.min.js )
Rails.application.config.assets.precompile += %w( fancybox/jquery.fancybox.js )
Rails.application.config.assets.precompile += %w( fancybox/helpers/jquery.fancybox-media.js )
Rails.application.config.assets.precompile += %w( populate_city_select.js )
Rails.application.config.assets.precompile += %w( owl.carousel.js )
Rails.application.config.assets.precompile += %w( jquery.rs.selectbox.js )
Rails.application.config.assets.precompile += %w( main.js )
