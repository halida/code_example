//-*-coding:utf-8-*-
//----------------------------------------------------------
// module: testyaml
//----------------------------------------------------------
#include <stdio.h>
#include <yaml.h>

int main(void)
{
  FILE *fh = fopen("c.yaml", "r");
  yaml_parser_t parser;

  /* Initialize parser */
  if(!yaml_parser_initialize(&parser))
    fputs("Failed to initialize parser!\n", stderr);
  if(fh == NULL)
    fputs("Failed to open file!\n", stderr);

  /* Set input file */
  yaml_parser_set_input_file(&parser, fh);

  /* CODE HERE */
  

  /* Cleanup */
  yaml_parser_delete(&parser);
  fclose(fh);
  return 0;
}
