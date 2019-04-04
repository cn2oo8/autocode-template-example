<%
  def varDomainName=tableNameUtil.lowerCaseFirst(tableDefine.id);
%>
	

	<!-- mybatis 配置开始-->
	
	<typeAlias type="${config.basePackage}.domain${PubUtils.addStrAfterSeparator(config.category,".")}.${tableDefine.id}" alias="${tableDefine.id}"/>

	<mapper resource="sqlmap${PubUtils.addStrAfterSeparator(config.category,"/")}/${tableDefine.id}.xml" />
	
	<bean id="${varDomainName}Dao" class="org.mybatis.spring.mapper.MapperFactoryBean">  
	   <property name="mapperInterface" value="${config.basePackage}.dao${PubUtils.addStrAfterSeparator(config.category,".")}.${tableDefine.id}Dao"/>
	  <property name="sqlSessionFactory" ref="sqlSessionFactory" />  
	</bean>
	
	<!-- mybatis 配置end-->



	<!-- ibatis 配置开始-->

	<sqlMap resource="sqlmap/${config.category}/${tableDefine.id}.xml" />
	
	<bean id="${varDomainName}Dao" class="${config.basePackage}.dao${PubUtils.addStrAfterSeparator(config.category,".")}.impl.${tableDefine.id}DaoImpl">
		<property name="dataSource" ref="dataSource" />
	</bean>
	<!-- ibatis 配置end-->


	

	requirejs:${extendConf['requirejs']}


		<%
			def requireInfo=requireUtil.getRequireInfo(tableModel,'allColumn');
			println requireInfo.getRequireText();

		%>




	<!-- 可选配置项 start -->
	<bean id="${varDomainName}Manager" class="${config.basePackage}.dao${PubUtils.addStrAfterSeparator(config.category,".")}.impl.${tableDefine.id}ManagerImpl">
	</bean>
	
	<bean id="${varDomainName}Service" class="${config.basePackage}.dao${PubUtils.addStrAfterSeparator(config.category,".")}.impl.${tableDefine.id}ServiceImpl">
	</bean>
	<!-- 可选配置项 end -->




	<!--struts config start-->
	<!-- ${tableDefine.cnname} -->
	<package name="${config.category}-${varDomainName}" namespace="/${config.category}/${varDomainName}" extends="jshow-admin">
		<action name="*" method="{1}" class="${config.basePackage}.web.action${PubUtils.addStrAfterSeparator(config.category,".")}.${tableDefine.id}Action">
			<result>\${path}/${config.category}/${varDomainName}/{1}.vm</result>
		</action>
	</package>
	<!--struts config end-->
	