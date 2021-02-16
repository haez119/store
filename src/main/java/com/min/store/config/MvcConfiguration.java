package com.min.store.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.multipart.commons.CommonsMultipartResolver;
import org.springframework.web.servlet.config.annotation.DefaultServletHandlerConfigurer;
import org.springframework.web.servlet.config.annotation.EnableWebMvc;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurerAdapter;

@Configuration
@ComponentScan(basePackages="com.min.store")
@EnableWebMvc
public class MvcConfiguration extends WebMvcConfigurerAdapter{

//	@Bean
//	public ViewResolver getViewResolver(){
//		InternalResourceViewResolver resolver = new InternalResourceViewResolver();
//		resolver.setPrefix("/WEB-INF/views/");
//		resolver.setSuffix(".jsp");
//		return resolver;
//	}
	
	@Override   
	public void configureDefaultServletHandling(DefaultServletHandlerConfigurer configurer) {
		// tiles 적용할 때 추가해야 되는 애?
		configurer.enable();
	}
	
	
	@Override
	public void addResourceHandlers(ResourceHandlerRegistry registry) {
		registry.addResourceHandler("/resources/**").addResourceLocations("/resources/");
		registry.addResourceHandler("/images/**").addResourceLocations("/images/");
	}

	@Bean CommonsMultipartResolver multipartResolver() {
		CommonsMultipartResolver mulit = new CommonsMultipartResolver();
		
		mulit.setMaxUploadSize(1024*10000); // 1024 => 1kb *10,000 => 10mb
		return mulit;
	}
	
	//메일
	//엑셀
}
