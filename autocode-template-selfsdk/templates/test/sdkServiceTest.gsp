<%
    def varDomainName = tableNameUtil.lowerCaseFirst(tableDefine.id);
    def managerName = varDomainName + "Manager";
    def pkColumn = tableDefine.getPkColumn();
    def pkJavaType = tableNameUtil.getDataType(pkColumn?.columnType);
%>package ${config.basePackage}.sdk.service.test${PubUtils.addStrAfterSeparator(config.category, ".")};

import ${config.basePackage}.sdk.domain${PubUtils.addStrAfterSeparator(config.category, ".")}.${tableDefine.id}Dto;
import ${config.basePackage}.sdk.service.AbstractSdkService;
import ${config.basePackage}.sdk.service${PubUtils.addStrAfterSeparator(config.category, ".")}.${tableDefine.id}SdkService;
import ${config.basePackage}.sdk.service.test${PubUtils.addStrAfterSeparator(config.category, ".")}.testdata.${tableDefine.id}MockProvider;
import ${config.basePackage}.sdk.domain.B2bUserResult;
import org.apache.commons.collections4.CollectionUtils;
import org.junit.After;
import org.junit.Assert;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import javax.annotation.Resource;
import java.util.List;

/**
 * ${tableDefine.cnname} 自动生成测试服务
 *
 * @author ${config.author}
 * @date ${config.nowDate}
 */
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"classpath*:spring-config-test.xml"})
public class ${tableDefine.id}SdkServiceTest {

    @Resource(name="${varDomainName}SdkService")
    ${tableDefine.id}SdkService ${varDomainName}SdkService;

    @Resource
    ${tableDefine.id}MockProvider ${varDomainName}MockProvider;

    /**
     * 增删改查，全链路测试
     */
    @Test
    public void testLinked(){
       //测试新增
        ${tableDefine.id}Dto addInfo = ${varDomainName}MockProvider.getMockDataHolder().getAddInfo();
        addInfo.setStatus(1);
        ${tableDefine.id}Dto addResult= ${varDomainName}SdkService.add(addInfo);
        Assert.assertNotNull(addResult);

        //测试修改
        ${tableDefine.id}Dto updateInfo = ${varDomainName}MockProvider.getMockDataHolder().getUpdateInfo();
        Long addPk = addResult.getId();
        updateInfo.setId(addPk);
        updateInfo.setStatus(1);
        int updateResult = ${varDomainName}SdkService.update(updateInfo);
        Assert.assertTrue(updateResult > 0);

        //列表查询，只查一条结果
        ${tableDefine.id}Dto queryDto=new ${tableDefine.id}Dto();
        queryDto.setId(addPk);
        List<${tableDefine.id}Dto> queryList =  ${varDomainName}SdkService.query(queryDto, null, 0, 10);
        Assert.assertTrue(CollectionUtils.size(queryList) == 1);
    }

}
