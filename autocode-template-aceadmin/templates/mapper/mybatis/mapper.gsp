<%
 
 def columns=tableDefine.columns;
 def mapName=tableDefine.id+"-Map";
 def cnt=0;
 def pkColumn=tableDefine.getPkColumn();
 def pkJavaType=tableNameUtil.getFullDataType(pkColumn?.columnType);
%><?xml version="1.0" encoding="UTF-8" ?> 
<!DOCTYPE mapper PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN" 
"http://mybatis.org/dtd/mybatis-3-mapper.dtd"> 
<mapper namespace="${config.basePackage}.dao${PubUtils.addStrAfterSeparator(config.category,"." )}.${tableDefine.id}Dao">

  <resultMap id="${tableDefine.id}-Map" type="${config.basePackage}.domain${PubUtils.addStrAfterSeparator(config.category,".")}.${tableDefine.id}">
 <%
     def columnNames=[];
     def dataNames=[];
 	  columns.each{
			if(it.getIsPK()){
				println """		<id property="${it.dataName}" column="${it.columnName}"/>""";  
				if(extendConf["autoKey"]!="true"){
					dataNames.add(it.dataName);
					columnNames.add(it.columnName);				
				}
			}else{
				println """		<result property="${it.dataName}" column="${it.columnName}"/>""";   
					dataNames.add(it.dataName);
					columnNames.add(it.columnName);	
			}

			
}%>
	</resultMap>


    <!-- 字段和bean里面一致，否则报错-->
	<sql id="BEAN-COMMON-SQL">
    	 <%
       List<String> list=tableModel.getSearchKeyList();
       if(list.size()!=0)
     	{
     	%>
    		<where>
    		<%
    		  list.each{
    		%><if test="${tableNameUtil.convertToBeanNames(it)} != null"> AND ${it} = #{${tableNameUtil.convertToBeanNames(it)}}</if>
    		<%
    		 }
    		%>
    		</where>
    	 <%
    	 }
    	 %>
    	</sql>


	<!-- 可以包含bean里面没有的字段-->
	<sql id="MAP-COMMON-SQL">
	 <%
        // List<String> list=tableModel.getSearchKeyList();
   if(list.size()!=0)
 	{
 	%>  
		<where>
		<%
		  list.each{
		%><if test="${tableNameUtil.convertToBeanNames(it)} != null"> AND ${it} = #{${tableNameUtil.convertToBeanNames(it)}}</if>
		<%
		 }
		%>
		</where>
	 <%
	 }
	 %>	
	</sql>
	
	<sql id="ORDER-SQL">
	 <%
	 def orderColumns=tableModel.orderColumns;
	 if(orderColumns!=null&&orderColumns.size()!=0){
	 	print "order by ";
	 	int i=0;
	 	orderColumns.each{
	 		print """${it.columnName} ${it.orderType}"""
	 		i++;
	 		if(i!=orderColumns.size()){
	 			print ",";
	 		}
	 	}
	 }
	 %>
	</sql>
	

	<sql id="All-FIELDS">
		${tableModel.getBizFields('allColumn')}
	</sql>

	<insert id="add" parameterType="${config.basePackage}.domain${PubUtils.addStrAfterSeparator(config.category,".")}.${tableDefine.id}">
		insert into ${tableDefine.dbTableName} (${PubUtils.listToStr(columnNames)})
			values(<%
			 cnt=1;
			 dataNames.each{
			    if(cnt==dataNames.size())
				print "#{"+it+"}"
			    else print "#{"+it+"},"
			    cnt++;
			 }
			%>)
    <%
      if(pkColumn!=null){
    %>
		<selectKey resultType="${pkJavaType}" keyProperty="${pkColumn.dataName}" order="AFTER">
		   select last_insert_id() as ID from dual
		</selectKey> 
   <%}%>
	 </insert>

    
    <update id="update" parameterType="${config.basePackage}.domain${PubUtils.addStrAfterSeparator(config.category,".")}.${tableDefine.id}" >
    	update  ${tableDefine.dbTableName} 
	<set>
<%
    	   columns.each{
	    if(pkColumn!=it){      
	    	   print """			<if test="${it.dataName} !=null"> ${it.columnName} = #{${it.dataName}},</if>\n"""
	     }
    	  }
%>
	</set>
	 where ${pkColumn.columnName} = #{${pkColumn.dataName}}
  	</update>
  
	

    <%
      if(pkColumn!=null){
    %>

	<delete id="deleteByPk" parameterType="${config.basePackage}.domain${PubUtils.addStrAfterSeparator(config.category,".")}.${tableDefine.id}">
		DELETE FROM ${tableDefine.dbTableName} WHERE ${pkColumn.columnName} = #{${pkColumn.dataName}}
	</delete>
	<select id="getByPk" resultMap="$mapName" parameterType="${pkJavaType}">
		SELECT  <include refid="All-FIELDS"/> FROM ${tableDefine.dbTableName}	WHERE ${pkColumn.columnName} = #{${pkColumn.dataName}}
	</select>  
    <%}%>



	<select id="getUnique" resultMap="$mapName" parameterType="${config.basePackage}.domain${PubUtils.addStrAfterSeparator(config.category,".")}.${tableDefine.id}">
		SELECT   <include refid="All-FIELDS"/> FROM ${tableDefine.dbTableName}
            <include refid="BEAN-COMMON-SQL" /> limit 1
	</select>


	<select id="getListByExample" resultMap="$mapName" parameterType="${config.basePackage}.domain${PubUtils.addStrAfterSeparator(config.category,".")}.${tableDefine.id}">
		SELECT   <include refid="All-FIELDS"/> FROM ${tableDefine.dbTableName}
            <include refid="BEAN-COMMON-SQL" />
	</select>

	
	<select id="getByPage" resultMap="$mapName" parameterType="java.util.HashMap">
			SELECT  <include refid="All-FIELDS"/> FROM ${tableDefine.dbTableName}
            <include refid="MAP-COMMON-SQL" />
            <include refid="ORDER-SQL" />
		LIMIT #{startIndex},#{pageSize}
	</select>
	
	<select id="count" resultType="java.lang.Integer" parameterType="java.util.HashMap">
		<![CDATA[
			SELECT COUNT(1) FROM ${tableDefine.dbTableName}
		]]>
		
              <include refid="MAP-COMMON-SQL" />
	</select>
	


</mapper>