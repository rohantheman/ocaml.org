let index = "/"
let packages = "/packages"
let packages_search = "/packages/search"
let with_hash = Option.fold ~none:"/p" ~some:(( ^ ) "/u/")
let package ?hash package = with_hash hash ^ "/" ^ package

let package_with_version ?hash ~canonical package version =
  if canonical then package else with_hash hash ^ "/" ^ package ^ "/" ^ version

let package_doc_root v = "/p/" ^ v ^ "/doc"

let package_doc_root_with_version ~canonical package version =
  if canonical then package_doc_root package
  else "/p/" ^ package ^ "/" ^ version ^ "/doc"

let package_doc ?hash ?page package =
  match page with
  | None -> with_hash hash ^ "/" ^ package ^ "/doc"
  | Some page -> with_hash hash ^ "/" ^ package ^ "/doc/" ^ page

let package_doc_with_version ?hash ?page ~canonical package version =
  if canonical then package_doc ?page package
  else
    match page with
    | None -> with_hash hash ^ "/" ^ package ^ "/" ^ version ^ "/doc"
    | Some page ->
        with_hash hash ^ "/" ^ package ^ "/" ^ version ^ "/doc/" ^ page

let community = "/community"
let success_story success_story = "/success-stories/" ^ success_story
let industrial_users = "/industrial-users"
let academic_users = "/academic-users"
let about = "/about"

let minor v =
  match String.split_on_char '.' v with
  | x :: y :: _ -> x ^ "." ^ y
  | _ -> invalid_arg (v ^ ": invalid OCaml version")

let v2 = "https://v2.ocaml.org"

let manual_with_version version =
  v2 ^ "/releases/" ^ minor version ^ "/htmlman/index.html"

let manual = "/releases/latest/manual.html"

let api_with_version version =
  v2 ^ "/releases/" ^ minor version ^ "/api/index.html"

let api = "/releases/latest/api/index.html"
let books = "/books"
let releases = "/releases"
let release release = "/releases/" ^ release
let workshop workshop = "/workshops/" ^ workshop
let blog = "/blog"
let news = "/news"
let news_post post = "/news/" ^ post
let jobs = "/jobs"
let carbon_footprint = "/policies/carbon-footprint"
let privacy_policy = "/policies/privacy-policy"
let governance = "/policies/governance"
let code_of_conduct = "/policies/code-of-conduct"
let playground = "/play"
let papers = "/papers"
let learn = "/docs"
let platform = "/docs/platform"
let ocaml_on_windows = "/docs/ocaml-on-windows"
let tutorial name = "/docs/" ^ name
let getting_started = tutorial "up-and-running"
let best_practices = "/docs/best-practices"
let problems = "/problems"
let installer = "/install-platform.sh"

let github_installer =
  "https://github.com/tarides/ocaml-platform-installer/releases/latest/download/installer.sh"
