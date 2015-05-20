package com.ogdencity.wmnsfconfidentialfunds.config;

import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistration;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurerAdapter;

/**
 * Created by tyler on 5/16/15.
 */
@Configuration
public class WebConfig extends WebMvcConfigurerAdapter {

    @Override
    public void addResourceHandlers(ResourceHandlerRegistry registry) {

        ResourceHandlerRegistration staticResources = registry
                .addResourceHandler("/static/**")
                .addResourceLocations("/WEB-INF/static/")
                .setCachePeriod(0);


    }
}
