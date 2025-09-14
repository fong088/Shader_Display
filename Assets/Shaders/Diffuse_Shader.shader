Shader "ACG/Diffuse_Shader"
{
    Properties
    {
        _Color ("Color", Color) = (1,1,1,1)
        _MainTex ("Texture", 2D) = "white" {}
    }

    SubShader
    {
      
        CGPROGRAM
        #pragma surface surf Lambert

        sampler2D _MainTex;
        fixed4 _Color;

        struct Input
        {
            float2 uv_MainTex;
        };

        void surf (Input IN, inout SurfaceOutput o)
        {
            fixed4 tex = tex2D(_MainTex, IN.uv_MainTex) * _Color;
            o.Albedo = tex.rgb;   
        }
        ENDCG
    }
    FallBack "Diffuse"
}
