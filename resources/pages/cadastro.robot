*** Settings ***
Resource    ../main.robot

*** Variables ***
${CAMPO_NOME}             id:form-nome
${CAMPO_CARGO}            id:form-cargo
${CAMPO_IMAGEM}           id:form-imagem
${CAMPO_TIME}             xpath=//div[@class='lista-suspensa']//select
${CAMPO_CARD}             id:form-botao
@{Selecionar_times}
...      //option[contains(.,'Programação')]
...      //option[contains(.,'Front-End')]
...      //option[contains(.,'Data Science')]
...      //option[contains(.,'Devops')] 
...      //option[contains(.,'UX e Design')]
...      //option[contains(.,'Mobile')]
...      //option[contains(.,'Inovação e Gestão')]

*** Keywords ***
Dado que eu preencha os campos do formulário   
    Input Text    ${CAMPO_NOME}        Arley
    Input Text    ${CAMPO_CARGO}       Desenvolvedor
    Input Text    ${CAMPO_IMAGEM}      https://picsum.photos/200/300
    Wait Until Element Is Visible    ${CAMPO_TIME}    5s
    Select From List By Label    ${CAMPO_TIME}    Programação

E clique no botão criar card
    Click Element    ${CAMPO_CARD}

Então identificar o card no time esperado
    Element Should Be Visible    class:colaborador

Entao identificar 3 cards no time esperado
    FOR    ${i}    IN RANGE    1        3
        Dado que eu preencha os campos do formulário
        E clique no botão criar card
    END
    Sleep    10s

Então criar e identificar um card em cada time disponível
    FOR    ${indice}    ${time}    IN ENUMERATE    @{Selecionar_times}
        Dado que eu preencha os campos do formulário
        Click Element    ${time}
        E clique no botão criar card
    END
    Sleep    5s

Dado que eu clique no botão criar card
    Click Element    ${CAMPO_CARD}

Então sistema deve apresentar mensagem de campo obrigatório
    Element Should Be Visible    id:form-nome-erro
    Element Should Be Visible    id:form-cargo-erro
    Element Should Be Visible    id:form-times-erro