package com.uanfcnccdam.lab04.config;

import org.springframework.boot.web.servlet.ServletRegistrationBean;
import org.springframework.context.ApplicationContext;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.core.io.ClassPathResource;
import org.springframework.ws.config.annotation.EnableWs;
import org.springframework.ws.config.annotation.WsConfigurerAdapter;
import org.springframework.ws.transport.http.MessageDispatcherServlet;
import org.springframework.ws.wsdl.wsdl11.DefaultWsdl11Definition;
import org.springframework.xml.xsd.SimpleXsdSchema;
import org.springframework.xml.xsd.XsdSchema;

@EnableWs
@Configuration
public class WebServiceConfiguration extends WsConfigurerAdapter {

    @SuppressWarnings({"rawtypes", "unchecked"})
    @Bean
    ServletRegistrationBean messageDispatcherServlet(ApplicationContext applicationContext) {
		MessageDispatcherServlet servlet = new MessageDispatcherServlet();
		servlet.setApplicationContext(applicationContext);
		servlet.setTransformWsdlLocations(true);
		return new ServletRegistrationBean(servlet, "/allService/*");
	}

    @Bean(name = "employees")
    DefaultWsdl11Definition defaultWsdl11Definition(XsdSchema employeeSchema) {
		DefaultWsdl11Definition wsdl11Definition = new DefaultWsdl11Definition();
		wsdl11Definition.setPortTypeName("allServiceSoapHttp");
		wsdl11Definition.setLocationUri("/allService");
		wsdl11Definition.setTargetNamespace("com.springbootsoap.allapis");
		wsdl11Definition.setSchema(employeeSchema);
		return wsdl11Definition;
	}


    @Bean
    XsdSchema employeeSchema() {
		return new SimpleXsdSchema(new ClassPathResource("employee.xsd"));
	}
	
}
