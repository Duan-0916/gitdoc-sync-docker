const core = require('@actions/core');
const axios = require('axios');
const {context} = require("@actions/github");
const fetch = require('node-fetch');


let notCare = getStarted();
async function getStarted() {
   const tips = core.getInput('tips', { required: true })

// 请求参数
const postData = {
    key1: 'value1',
    key2: 'value2'
};

// 发起POST请求
fetch('http://www.example.com/endpoint', {
    method: 'POST',
    body: JSON.stringify(postData),
    headers: { 'Content-Type': 'application/json' }
})
.then(res => res.json())
.then(data => console.log(data))
.catch(err => console.error(err));
    core.setOutput("success");
}

function sleep(seconds) {
    return new Promise(resolve => setTimeout(resolve, seconds * 1000));
}
module.exports = getStarted;
