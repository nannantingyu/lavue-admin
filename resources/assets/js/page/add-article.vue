<template>
    <div>
        <p>{{ article.title }}</p>
        <p>{{ article.author }}</p>
        <p>{{ article.publish_time }}</p>
        <p>{{ article.description }}</p>
        <ContentEditor :body="body"></ContentEditor>
    </div>
</template>

<script>
    import ContentEditor from '../components/content-editor'
    import {mapActions, mapState} from 'vuex'
    export default {
        name: "article-page",
        components: {ContentEditor},
        computed: {
            ...mapState({
                'body': state=>state.article.body,
                'article': state=>state.article.article_now
            })
        },
        mounted() {
            console.log(this.$router);
            this.getArticle(this.$route.params.id);
        },
        methods: {
            ...mapActions({
                'getArticle': 'article/getArticle'
            })
        }
    }
</script>

<style scoped>

</style>