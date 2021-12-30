<script>
	import Navbar from "../components/Navbar.svelte";
</script>

<Navbar/>
<div id="not-found">
	Page Not Found
</div>

<style>
	#not-found {
		color: #ff235a;
		text-transform: uppercase;
		font-size: 3em;
		font-weight: 100;
		position: absolute;
		width: 100%;
		height: calc(100% - 3.25em);
		display: flex;
		justify-content: center;
		align-items: center;
	}
</style>
