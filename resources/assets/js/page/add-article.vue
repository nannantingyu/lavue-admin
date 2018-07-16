<template>
    <div>
        <p>{{ article.title }}</p>
        <p>{{ article.author }}</p>
        <p>{{ article.publish_time }}</p>
        <p>{{ article.description }}</p>
        <ContentEditor :body="body"></ContentEditor>
        <!--<MarkdownEditor></MarkdownEditor>-->
    </div>
</template>

<script>
    import ContentEditor from '../components/ContentEditor'
    import MarkdownEditor from '../components/MarkdownEditor'

    export default {
        name: "article-page",
        components: {ContentEditor, MarkdownEditor},
        data() {
            return {
                body: "",
                article: {}
            }
        },
        mounted() {
            this.getArticle();
        },
        methods: {
            getArticle: function() {
                let _this = this;
                axios.get("/api/article/info?id="+this.$route.params.id).then(function(data){
                    _this.article = data.data[0];
                    // _this.editor.setValue(article['body']);
                    _this.body = data.data[0]['body'];
                });
            },
        }
    }
</script>

<style scoped>

</style>