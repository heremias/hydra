import Home from "./routes/Home.svelte";
import NotFound from "./routes/NotFound.svelte";
import Form from "./routes/Form.svelte";
import List1 from "./routes/List1.svelte";
import List2 from "./routes/List2.svelte";

export default {
  "/": Home,
  "/form/*": Form,
  "/list1/*": List1,
  "/list2/*": List2,
  "*": NotFound,
};
