<script>
	import Router from 'svelte-spa-router';
	import routes from './routes';
</script>

<main>
	<Router {routes} />
</main>

<style>
	main {
		padding: 0em;
		margin: 0 0;
	}
</style>
