<template>
    <div>
        <textarea :id="editorName" placeholder="Balabala" autofocus>
            {{ body }}
        </textarea>
    </div>
</template>

<script>
    import 'simditor/styles/simditor.css';
    import $ from 'jquery';
    import Simditor from 'simditor';
    import axios from 'axios';

    export default {
        name: "contenteditor",
        props: ['body'],
        data() {
            return {
                editorName: new Date().getTime(),
                toolbar: "请输入..."
            }
        },
        mounted() {
            this.createEditor()
        },
        methods: {
            getArticle: function() {
                let _this = this;
                axios.get("/api/article/info?id="+this.$route.params.id).then(function(data){
                    const article = data.data[0];
                    _this.editor.setValue(article['body']);
                });
            },
            get_content: function () {
                return this.editor.getValue()
            },
            createEditor() {
                const _this = this;
                this.editor = new Simditor({
                    textarea: $('#' + _this.editorName),
                    toolbar: _this.toolbar,
                    upload: {
                        url: '/api/uploads/images',
                        fileKey: 'fileDataFileName',
                        connectionCount: 3,//同时上传个数
                        leaveConfirm: '正在上传文件'
                    },
                    pasteImage: true,
                    tabIndent: true,
                });

                this.editor.on("valuechanged", function(e, src) {
                    console.log("valuechanged");
                    _this.$emit('setbody', _this.get_content());
                });
            }
        },
        watch: {
            body: function(newValue) {
                this.editor.setValue(newValue)
            }
        }
    }
</script>

<style scoped>
</style>