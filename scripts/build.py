import jinja2
import yaml

template_dirs = ['.', 'src']

def write_index_html(jinja2_config, jinja2_template, output_html_path):
    with open(jinja2_config) as f:
        config = yaml.safe_load(f.read())
    env = jinja2.Environment(
            loader=jinja2.FileSystemLoader(template_dirs),
            undefined=jinja2.StrictUndefined,
            cache_size=0,
            trim_blocks=True,
            lstrip_blocks=True)
    template = env.get_template(jinja2_template)
    with open(output_html_path, "w") as out_f:
        print(template.render(**config), file=out_f)

if __name__ == "__main__":
    import argparse
    parser = argparse.ArgumentParser(description="Build a self-contained HTML file with Jinja2, using the context from a yaml file")
    parser.add_argument("jinja2_config")
    parser.add_argument("jinja2_template")
    parser.add_argument("output_html_path")
    args = parser.parse_args()
    write_index_html(args.jinja2_config, args.jinja2_template, args.output_html_path)
